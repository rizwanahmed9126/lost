// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:lost_tracking/constant/enum.dart';
import 'package:lost_tracking/models/user_contact.dart';
import 'package:location/location.dart' as loc;

import 'package:lost_tracking/models/user.dart';
import 'package:lost_tracking/screens/reset_password_screen.dart';
import 'package:lost_tracking/services/firebase_service.dart';
import 'package:lost_tracking/services/http_service.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/services/storage_service.dart';
import 'package:lost_tracking/services/util_service.dart';
import 'package:lost_tracking/utils/routes.dart';
import 'package:lost_tracking/utils/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  NavigationService? navigationService = locator<NavigationService>();
  UtilService? utilService = locator<UtilService>();

  StorageService? storageService = locator<StorageService>();
  HttpService? http = locator<HttpService>();
  FirebaseService? _firebase = locator<FirebaseService>();
  AppUser? _user;
  List<AddContact> userContacts = [];
  AddContact? userContactInfo;
  bool isLoadingProgress = false;

  String? token;
  // ignore: unused_field
  String? _password;
  String? phoneNumber;
  bool _isRemeber = false;
  Map<String, String> latlng = {};

  // get getUserContact {
  //   return this.userContactInfo;
  // }

  // set addContact(AddContact userInfo) {
  //   this.userContactInfo = userInfo;
  // }

  get user {
    return this._user;
  }

  setuser(AppUser user) {
    this._user = user;
  }

  bool get loader {
    return this.isLoadingProgress;
  }

  setIsRemeber(bool val) async {
    await this.storageService!.setBoolData('isRemember', val);
    this._isRemeber = val;
  }

  get getIsRemember {
    return this._isRemeber;
  }

  setisLoadingProgress(bool check) {
    this.isLoadingProgress = check;
    notifyListeners();
  }

  get getAllContacts {
    return this.userContacts;
  }

  setLatLng(String lat, String lng) {
    this.latlng = {
      'latitude': lat,
      'longitude': lng,
    };
    notifyListeners();
  }

  get getLatLng {
    return this.latlng;
  }

  Future<void> setCountryName(String countryName, String address) async {
    this._user!.country = countryName;
    this.user!.address = address;
    var data = {
      "id": this._user!.id,
      "country": this._user!.country,
      "address": this.user!.address
    };
    await this.http!.editProfileInformation(data);
  }

  Future<void> signinWithEmailAndPassword(
      String? email, String? password) async {
    var result;
    try {
      this._password = password;
      await storageService!
          .setData(StorageKeys.password.toString(), this._password);
      final user =
          await _firebase!.signinWithEmailAndPassword(email!, password!);
      var token = await user.getIdToken();
      await this
          .storageService!
          .setData(StorageKeys.token.toString(), token.toString());
      this.token = token.toString();
      if (user.emailVerified) {
        await this.getFCMToken();
        var response = await this.http!.getUserById(user.uid);
        await Future.delayed(const Duration(seconds: 1));
        result = response.data;

        // var displayName =
        //     result['data']['firstName'][0].toString().toUpperCase() +
        //         result['data']['firstName'].toString() +
        //         " " +
        //         result['data']['lastName'].toString()[0].toUpperCase() +
        //         result['data']['lastName'].toString();
        this._user = AppUser(
            email: user.email,
            firstName: result['data']['firstName'].toString(),
            lastName: result['data']['lastName'].toString(),
            displayName: result['data']['displayName'].toString(),
            id: user.uid,
            phoneNumber: result['data']['phoneNumber'].toString(),
            isPremium: result['data']['isPremium'],
            package: result['data']['package'],
            country: result['data']['country'],
            address: result['data']['address'],
            profileImageUrl: result['data']['profileImageUrl']);

        if (this._isRemeber) {
          await this.storageService!.setData("userEmail", this._user!.email);
          await this.storageService!.setData("password", this._password);
          await this.storageService!.setBoolData("rememberMe", this._isRemeber);
        } else {
          await this.storageService!.setBoolData("rememberMe", this._isRemeber);
        }
        this.storageService!.setData('user', this._user);
        await getAllUserContacts();
        navigationService!.navigateTo(HomeScreenRoute);
        return;
      } else {
        this._user = AppUser(
          email: user.email,
        );
        await _firebase!.sendEmailVerification();
        navigationService!.navigateTo(EmailVerificationScreenRoute);
        return;
      }
    } on FirebaseAuthException catch (err) {
      // if (user == null)
      //   utilService!.showToast("This account does not exist");
      // else
      utilService!.showToast(err.message.toString());
    }
  }

  Future signUpUser() async {
    try {
      await _firebase!.sendEmailVerification();
      navigationService!.navigateTo(EmailVerificationScreenRoute);
    } on FirebaseAuthException catch (err) {
      utilService!.showToast(err.message.toString());
    }
  }

  refreshToken() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var user = _auth.currentUser!;
    var token = await user.getIdToken(true);
    await storageService!.setData(StorageKeys.token.toString(), token);
  }

  Future getCurrentLocation() async {
    loc.Location location = new loc.Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        var _locationData = await location.getLocation();
        print(
            'lat :  ${_locationData.latitude} lng :  ${_locationData.longitude}');
        final coordinates =
            new Coordinates(_locationData.latitude, _locationData.longitude);
        var addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        await setCountryName(
            first.countryName.toString(), first.addressLine.toString());

        setLatLng(_locationData.latitude.toString(),
            _locationData.longitude.toString());
        print("${first.featureName} : ${first.addressLine}");
      }
    }
    if (_permissionGranted == PermissionStatus.granted) {
      var _locationData = await location.getLocation();
      print(
          'lat :  ${_locationData.latitude} lng :  ${_locationData.longitude}');
      final coordinates =
          new Coordinates(_locationData.latitude, _locationData.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      await setCountryName(
          first.countryName.toString(), first.addressLine.toString());

      setLatLng(_locationData.latitude.toString(),
          _locationData.longitude.toString());
      print("${first.featureName} : ${first.addressLine}");
    }
  }

  Future<void> getFCMToken() async {
    try {
      var token = await _firebase!.getFCMToken();
      Map<String, dynamic> data = {
        "fcmToken": token,
        "userId": this._user!.id,
        "type": Platform.isAndroid ? "android" : "ios"
      };
      await this.http!.registerDevice(data);
    } catch (err) {
      // print(err);
    }
  }

  Future<void> createUserWithEmailPassword(String email, String password,
      String firstName, String lastName, String phoneNumber) async {
    try {
      final user =
          await _firebase!.createUserWithEmailAndPassword(email, password);
      var token = await user.getIdToken(true);
      await this
          .storageService!
          .setData(StorageKeys.token.toString(), token.toString());
      this._user = AppUser(
          email: user.email,
          lastName: lastName,
          displayName: firstName[0].toUpperCase() +
              firstName +
              " " +
              lastName[0].toUpperCase() +
              lastName,
          firstName: firstName,
          id: user.uid,
          phoneNumber: phoneNumber);
      await this.http!.signUp(
        {
          "email": user.email,
          "firstName": firstName,
          "lastName": lastName,
          "id": user.uid,
          "phoneNumber": phoneNumber,
          "displayName": firstName[0].toUpperCase() +
              firstName.substring(1) +
              " " +
              lastName[0].toUpperCase() +
              lastName.substring(1),
        },
        user.uid,
      );
      await signUpUser();
    } on FirebaseAuthException catch (err) {
      utilService!.showToast(err.message.toString());
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final user = await _firebase!
          .signinWithEmailAndPassword(this._user!.email!, oldPassword);
      await user.updatePassword(newPassword);
      navigationService!.navigateTo(ResetPasswordSuccessfullyScreenRoute);
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }

  Future<void> editProfileInformation(
    String userName,
    String phoneNumber,
    String address,
    String email,
    String? imageUrl,
  ) async {
    try {
      Map<String, dynamic> data = {
        "id": this._user!.id,
        "displayName": userName,
        "phoneNumber": phoneNumber,
        "address": address,
        "email": email,
        "profileImageUrl": imageUrl
      };
      var response = await this.http!.editProfileInformation(data);
      var result = response.data;
      if (result != null) {
        var data = this._user!;
        this._user = AppUser.fromJson(result['data']);
        this._user!.id = data.id;
        // this._user!.isEmailVerified = data.isEmailVerified;
        await this.storageService!.setData('user', this._user);
        notifyListeners();
        navigationService!.navigateTo(HomeScreenRoute);
      }
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }

  Future<void> addUserContact(
    String name,
    String phoneNumber,
    String address,
    String relation,
  ) async {
    try {
      Map<String, dynamic> data = {
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "name": name,
        "phoneNumber": phoneNumber,
        "relation": relation,
        "address": address
      };
      var response = await this.http!.addUserContact(data, _user!.id);
      var result = response.data;
      if (result != null) {
        this.userContacts = [];
        for (var i = 0; i < result['data'].length; i++) {
          this.userContacts.add(AddContact.fromJson(result['data'][i]));
        }
        notifyListeners();
        // await getAllUserContacts();
        navigationService!.navigateTo(SendMessageScreenRoute);
      }
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }

  Future<void> logoutFirebaseUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    var sharedPreferences = await SharedPreferences.getInstance();
    this.userContacts = [];
    try {
      var token = await _firebase!.getFCMToken();
      Map<String, dynamic> data = {
        "fcmToken": token,
        "userId": this._user!.id,
        "type": Platform.isAndroid ? "android" : "ios"
      };
      await this.http!.unRegisterDevice(data);
      var rememberMe = await this.storageService!.getBoolData("rememberMe");
      if (rememberMe ?? false) {
        sharedPreferences.remove(StorageKeys.token.toString());
        sharedPreferences.remove("route");
      } else {
        sharedPreferences.clear();
      }

      // navigationService!.navigateTo(LoginScreenRoute);
    } catch (err) {
      print(err);
    }
  }

  Future<void> getAllUserContacts() async {
    this.userContacts = [];
    var response = await this.http!.getAllUserContacts(this._user!.id);
    var result = response.data;
    for (var i = 0; i < result['data'].length; i++) {
      this.userContacts.add(AddContact.fromJson(result['data'][i]));
    }
    notifyListeners();
    print(this.userContacts);
  }
}

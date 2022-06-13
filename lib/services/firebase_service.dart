import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../services/storage_service.dart';
import '../services/navigation_service.dart';
import '../services/util_service.dart';
import '../utils/service_locator.dart';
import '../utils/routes.dart';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UtilService _util = locator<UtilService>();
  NavigationService _navigation = locator<NavigationService>();
  // ignore: unused_field
  StorageService _storage = locator<StorageService>();

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _util.showToast(
          "An email has been sent please follow the instructions and recover your password.");
      _navigation.navigateTo(LoginScreenRoute);
    } on FirebaseAuthException catch (err) {
      _util.showToast(err.message.toString());
    }
  }

  // Future<void> logoutFirebaseUser() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   await _auth.signOut();
  //   await _storage.clearData();
  // }

  signinWithEmailAndPassword(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return authResult.user;
  }

  sendEmailVerification() async {
    final user = _auth.currentUser;
    user!.sendEmailVerification();
    _util.showToast("A Verification email has been sent");
  }

  resendEmailVerification() async {
    final user = _auth.currentUser;
    await user!.sendEmailVerification();
    _util.showToast(
        "A Verification Link Resend to your email kindly check your inbox");
  }

  createUserWithEmailAndPassword(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return authResult.user;
  }

  // uploadPicture(File file, String fileName, String id) async {
  //   try {
  //     StorageReference storageReference;
  //     storageReference = FirebaseStorage.instance.ref().child("files/$id");
  //     final StorageUploadTask uploadTask = storageReference.putFile(file);
  //     final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
  //     final String url = (await downloadUrl.ref.getDownloadURL());
  //     return url;
  //   } catch (err) {
  //     // print(err);
  //   }
  // }

  getFCMToken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    return token;
  }
}

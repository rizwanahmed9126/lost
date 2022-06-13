import 'package:flutter/cupertino.dart';
import 'package:lost_tracking/models/contact_info.dart';
import 'package:lost_tracking/services/http_service.dart';
import 'package:lost_tracking/services/navigation_service.dart';
import 'package:lost_tracking/services/storage_service.dart';
import 'package:lost_tracking/services/util_service.dart';
import 'package:lost_tracking/utils/service_locator.dart';

class ContactInfoProvider with ChangeNotifier {
  NavigationService? navigationService = locator<NavigationService>();
  UtilService? utilService = locator<UtilService>();
  StorageService? storageService = locator<StorageService>();
  HttpService? http = locator<HttpService>();
  ContactInfo? _user;
  String? token;
  String? phonNumber;
  bool isLoadingProgress = false;

  ContactInfo? get getuser {
    return this._user;
  }

  setuser(ContactInfo user) {
    return this._user = user;
  }

  setisLoadingProgress(bool check) {
    this.isLoadingProgress = check;
    notifyListeners();
  }

  Future<void> addContactInfo(
    String contactName,
    String phoneNumber,
    String address,
    String relation,
  ) async {
    try {
      Map<String, dynamic> data = {
        "id": this._user!.id,
        "contactName": contactName,
        "phoneNumber": phoneNumber,
        "relation": relation,
        "address": address,
      };

      notifyListeners();
    } catch (err) {
      utilService!.showToast(err.toString());
    }
  }
}

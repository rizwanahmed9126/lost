import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class UtilService {
  // FirebaseService firebaseService = locator<FirebaseService>();

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[300],
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Future<String> captureImage(String? userId) async {
    firebase_storage.Reference storageReference;
    // ignore: deprecated_member_use
    final picker = ImagePicker();
    File _image;
    var imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return '';
    }
    _image = File(imageFile.path);
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _image.copy('${appDir.path}/$fileName');
    storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child("images/$userId");
    final firebase_storage.UploadTask uploadTask =
        storageReference.putFile(savedImage);
    final firebase_storage.TaskSnapshot downloadUrl =
        (await uploadTask.whenComplete(() => null));
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }

  Future<String> browseImage(String? userId) async {
    firebase_storage.Reference storageReference;

    final picker = ImagePicker();
    File _image;
    var imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return '';
    }
    _image = File(imageFile.path);
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _image.copy('${appDir.path}/$fileName');
    storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child("images/$userId");
    final firebase_storage.UploadTask uploadTask =
        storageReference.putFile(savedImage);
    final firebase_storage.TaskSnapshot downloadUrl =
        (await uploadTask.whenComplete(() => null));
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }
}

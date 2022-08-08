// ignore_for_file: unused_import

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, String email) async {
    Reference ref = _storage.ref().child(childName).child(email);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> removeImageFromStorage(String childName, String email) async {
    Reference ref = _storage.ref().child(childName).child(email);
    return ref.delete();
  }
}

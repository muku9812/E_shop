import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practise/model/contactUsModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ContactUsProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final fireStore = FirebaseFirestore.instance.collection('contact_us');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> addData(String name, String email, String feedback) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    ContactUsModel contactUsModel =
        ContactUsModel(id: id, name: name, feedback: feedback, email: email);

    await fireStore.doc(id).set(contactUsModel.toJson()).then((value) {
      loading = false;
    });
    loading = false;
    notifyListeners();
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:practise/model/productModel.dart';

class ProductProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final fireStore = FirebaseFirestore.instance.collection('products');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> addProduct(String title, String description, File image) async {
    loading = true;
    String? imageUrl;
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    firebase_storage.Reference productRef =
        firebase_storage.FirebaseStorage.instance.ref('product/$title$id');
    if (image != null) {
      firebase_storage.TaskSnapshot uploadTask =
          await productRef.putFile(image);
      imageUrl = await uploadTask.ref.getDownloadURL();
      ProductModel productModel = ProductModel(
          id: id, title: title, description: description, image: imageUrl);
      await fireStore.doc(id).set(productModel.toJson()).then((value) {
        loading = false;
      });
      loading = false;
      notifyListeners();
    }
  }
}

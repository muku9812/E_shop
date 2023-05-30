import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:practise/model/productModel.dart';
import 'package:provider/provider.dart';

class ProductProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<ProductModel> latestProductList = [];

  final fireStore = FirebaseFirestore.instance.collection('products');
  final summerCollectionFirestore =
      FirebaseFirestore.instance.collection('summerCollection');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

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
        id: id,
        title: title,
        description: description,
        image: imageUrl,
        uid: auth.currentUser!.uid,
      );
      await fireStore.doc(id).set(productModel.toJson()).then((value) {
        loading = false;
      });
      loading = false;
      notifyListeners();
    }
  }

  static Stream<List<ProductModel>> getLatestProducts() =>
      FirebaseFirestore.instance
          .collection('products')
          .orderBy(
            FieldPath.documentId,
          )
          .limit(10)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ProductModel.fromJson(doc.data()))
              .toList());

  Future<void> addToSummerCollection(
      String title, String description, File image) async {
    loading = true;
    String? imageUrl;
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    firebase_storage.Reference productRef = firebase_storage
        .FirebaseStorage.instance
        .ref('summerProduct/$title$id');
    if (image != null) {
      firebase_storage.TaskSnapshot uploadTask =
          await productRef.putFile(image);
      imageUrl = await uploadTask.ref.getDownloadURL();
      ProductModel productModel = ProductModel(
        id: id,
        title: title,
        description: description,
        image: imageUrl,
        uid: auth.currentUser!.uid,
      );
      await summerCollectionFirestore
          .doc(id)
          .set(productModel.toJson())
          .then((value) {
        loading = false;
      });
      loading = false;
      notifyListeners();
    }
  }

  static Stream<List<ProductModel>> getSummerProducts() =>
      FirebaseFirestore.instance
          .collection('summerCollection')
          .orderBy(FieldPath.documentId)
          .limit(10)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ProductModel.fromJson(doc.data()))
              .toList());
}

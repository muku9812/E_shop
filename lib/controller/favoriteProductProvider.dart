import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:practise/model/favouriteModel.dart';

class FavoriteProductProvider with ChangeNotifier {
  final fireStore = FirebaseFirestore.instance.collection('favourite_list');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> addFavourite(String productId, String title, String description,
      String imageUrl) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    FavouriteModel favouriteModel = FavouriteModel(
        id: id,
        title: title,
        productId: productId,
        description: description,
        imageUrl: imageUrl);
    await fireStore.doc(id).set(favouriteModel.toJson());
    notifyListeners();
  }

  fetchFavourite(Function cb) {
    FirebaseFirestore.instance.collection('favourite_list').snapshots().listen(
      (event) {
        cb(event.docs.map((e) => FavouriteModel.fromJson(e.data())).toList());
      },
    );

    notifyListeners();
  }
}

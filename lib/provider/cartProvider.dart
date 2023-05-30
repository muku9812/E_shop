import 'package:practise/model/productModel.dart';
import 'package:flutter/material.dart';


class CartProvider extends ChangeNotifier{

  List<Product> productList = [];

  void addToProductList(Product product){
    productList.add(product);
    notifyListeners();

  }





}
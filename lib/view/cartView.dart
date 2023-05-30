import 'package:flutter/material.dart';
import 'package:practise/provider/cartProvider.dart';
import 'package:practise/view/homeView.dart';
import 'package:provider/provider.dart';


class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<CartProvider>(
            builder: (context, value, child) => ListView.builder(
              itemBuilder: (context, index) => ReusableCard(imageUrl: value.productList[index].productImageUrl, height: MediaQuery.of(context).size.height, width:MediaQuery.of(context).size.width, name:
              value.productList[index].productName) ,
              itemCount: value.productList.length,
            )),
      ),
    );
  }
}

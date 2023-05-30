import 'package:flutter/material.dart';

import '../utilities.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
    required this.images,
    required this.i,
    required this.height,
    required this.width,
    required this.name,
  });

  final List<String> images;
  final int i;
  final double height;
  final double width;
  final List<String> name;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Image(
            image: NetworkImage(images[i]),
            fit: BoxFit.fill,
            height: height * 0.19,
            width: width * 0.45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 4, right: 6, left: 10, bottom: 10),
                child: Container(
                  height: height * 0.03,
                  width: width * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      name[i],
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: SizedBox(
                  height: height * 0.03,
                  width: width * 0.15,
                  child: InkWell(
                      onTap: () {
                        Utils.toastMessage('${name[i]} added to cart');
                      },
                      child: const Icon(Icons.add_shopping_cart_sharp)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FavoriteProduct extends StatefulWidget {
  const FavoriteProduct({super.key});

  @override
  State<FavoriteProduct> createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
              titleSpacing: 0.0,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              title: Text(
                'Favourite list',
                style: TextStyle(color: Colors.black),
              ),
              floating: true,
              expandedHeight: 60,
              flexibleSpace: FlexibleSpaceBar()),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                child: ListTile(
                    leading: Container(
                      height: 100,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    title: Text('Item $index'),
                    subtitle: Text('sub-title'),
                    trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text('Remove'),
                                  ))
                            ])),
              );
            }, childCount: 20)),
          )
        ],
      ),
    ));
  }
}













// SafeArea(
//         child: Column(children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Icon(
//                   Icons.arrow_back,
//                   color: Colors.black,
//                   size: 30,
//                 ),
//               ),
//               const Text(
//                 'Favourite products',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const Icon(
//                 Icons.more_vert,
//                 size: 30,
//               ),
//             ],
//           ),
//           Divider(),
//           const Padding(
//             padding: EdgeInsets.only(top: 10, left: 4, right: 8),
//             child: Card(
//               child: ListTile(
//                   leading: CircleAvatar(),
//                   title: Text('Jacket'),
//                   subtitle: Text('Jacket for man.'),
//                   trailing: Icon(
//                     Icons.more_vert,
//                     size: 24,
//                   )),
//             ),
//           )
//         ]),
//       ),
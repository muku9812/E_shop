import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practise/controller/productProvider.dart';
import 'package:practise/model/productModel.dart';
import 'package:practise/utilities/routes/routesName.dart';
import 'package:practise/utilities/utilities.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../utilities/widgets/latestProductWidget.dart';
import '../utilities/widgets/summerCollectionCard.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int items = 1;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        bottomOpacity: 0,
        shadowColor: Colors.white,
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Utils.snackBar('search', context);
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: badges.Badge(
                badgeContent: Text('3'),
                child: Icon(
                  Icons.favorite_outline,
                  size: 30,
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 16, left: 8),
              child: Center(
                child: badges.Badge(
                  badgeContent: Text(items.toString()),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                  ),
                ),
              )),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 154, 226, 45),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              accountName: const Text('Mukesh Mandal'),
              accountEmail: Text(auth.currentUser!.email.toString()),
              currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://marketplace.canva.com/EAFEits4-uw/1/0/1600w/canva-boy-cartoon-gamer-animated-twitch-profile-photo-oEqs2yqaL8s.jpg')),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Contact us.'),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.contact);
              },
            ),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('About us.'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings.'),
            ),
            ListTile(
              onTap: () {
                auth.signOut().then((value) {
                  Navigator.restorablePushNamedAndRemoveUntil(
                      context, RoutesName.login, (route) => false);
                }).then((value) {
                  Utils.snackBar("Logout successfully.", context);
                }).onError((error, stackTrace) {
                  Utils.flushBarErrorMessage(error.toString(), context);
                });
              },
              leading: const Icon(Icons.logout),
              title: const Text('Logout.'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.addProduct);
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.05,
              width: double.infinity,
              color: Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: height * 0.26,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: NetworkImage(
                            'https://www.rd.com/wp-content/uploads/2022/08/GettyImages-1395657872-e1660072866664.jpg?fit=700,1024'),
                        fit: BoxFit.fill)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.02, right: width * 0.02, top: height * 0.018),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Latest Product',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'View more',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
            StreamBuilder<List<ProductModel>>(
                stream: ProductProvider.getLatestProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  } else if (snapshot.hasData) {
                    final latestProducts = snapshot.data!;
                    List<String> names = [];
                    List<String> images = [];
                    for (int i = 0; i < latestProducts.length; i++) {
                      names.add(latestProducts[i].title);
                      images.add(latestProducts[i].image);
                    }
                    return LatestProduct(
                        name: names,
                        height: height,
                        images: images,
                        width: width);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.02, right: width * 0.02, top: height * 0.018),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Summer Collections',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'View more',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.82,
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.8,
                ),
                children: <Widget>[
                  StreamBuilder<List<ProductModel>>(
                      stream: ProductProvider.getSummerProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        } else if (snapshot.hasData) {
                          final summerProductList = snapshot.data!;
                          List<String> names = [];
                          List<String> images = [];
                          for (int i = 0; i < summerProductList.length; i++) {
                            names.add(summerProductList[i].title);
                            images.add(summerProductList[i].image);
                          }
                          for (int i = 0; i < summerProductList.length;) {
                            return ReusableCard(
                                images: images,
                                i: i,
                                height: height,
                                width: width,
                                name: names);
                          }
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

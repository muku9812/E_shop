import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practise/utilities/routes/routesName.dart';
import 'package:practise/utilities/utilities.dart';
import 'package:badges/badges.dart' as badges;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> images = [
    'https://filson-canto.imgix.net/sfi96vqojp2kf0cc843vdqhh0s/473jyYlXduHPdRoGSzAvpZdHeLQ/original?h=800&w=800&bg=0FFF&q=80&auto=format,compress&fit=fillmax',
    'https://www.backcountry.com/images/items/large/FSN/FSN0058/BK.jpg',
    'https://www.beaubags.com/media/catalog/product/cache/3/image/0dc2d03fe217f8c83829496872af24a0/f/i/filson-tin-cloth-short-lined-cruiser-black-front.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRi33kxa6WQ3g94bxPrIs_oCRWQ-fCpdPejIkRFc-iryQ8JzHkhPoW-__gOGkMwcfdVALc&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_bx6K-948sY3zl0Wa8BupQw5u8huj4ZTz082MGaNKXQVDwEqeH-BjpFJCAJmlzox3xzo&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEktpWHqEk1HaxWg5P1Xr00hCjF_TF7vi38df01n9GfY_fnosqFI4sDVl_7UymcyEjZYs&usqp=CAU'
  ];
  List<String> name = [
    'Jacket',
    'T-shirt',
    'pant',
    'Jockers',
    'vest',
    'sweater'
  ];
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
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 10),
                  child: Row(
                    children: [
                      for (int i = 0; i < 6; i++)
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              name[i],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Icon(
                                              Icons.favorite_outline,
                                              color: Colors.black,
                                              size: 30,
                                            )
                                          ],
                                        ),
                                        content: SizedBox(
                                          height: height * 0.4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Card(
                                                child: Image(
                                                  image:
                                                      NetworkImage(images[i]),
                                                  fit: BoxFit.fill,
                                                  height: height * 0.29,
                                                  width: double.maxFinite,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRect(
                                                  child: RichText(
                                                      text: TextSpan(
                                                          text:
                                                              'Description:- ',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16),
                                                          children: const [
                                                        TextSpan(
                                                            text:
                                                                'In literary theory, a text is any object that can be "read", whether this object is a work of literature, a street sign, an arrangement of buildings on a city block, or styles of clothing.',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )),
                                                      ])),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Add to Cart'))
                                        ]);
                                  });
                            },
                            child: Container(
                              height: height * 0.15,
                              width: width * 0.29,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(images[i]),
                                      fit: BoxFit.fill)),
                              child: Center(
                                child: Text(
                                  name[i],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )),
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
                  for (int i = 0; i <= 5; i++)
                    ReusableCard(
                        images: images,
                        i: i,
                        height: height,
                        width: width,
                        name: name),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
                        Set();
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

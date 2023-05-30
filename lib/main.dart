import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practise/controller/contactUsProvider.dart';
import 'package:practise/controller/favoriteProductProvider.dart';
import 'package:practise/controller/productProvider.dart';
import 'package:practise/model/productModel.dart';
import 'package:practise/utilities/routes/routes.dart';
import 'package:practise/utilities/routes/routesName.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<ProductModel>>(
          create: (context) => ProductProvider.getLatestProducts(),
          initialData: [],
        ),
        ChangeNotifierProvider(create: (context) => ContactUsProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

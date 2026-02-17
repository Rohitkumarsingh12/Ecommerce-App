import 'package:ecommerceapp/view/productlists%20creen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/apihelper.dart';
import 'controller/cartprovider.dart';
import 'controller/productprovider.dart';


// Main function jaha se Flutter app start hota hai
void main() {
  runApp(

    // MultiProvider use kiya gaya hai taaki multiple providers app me available ho
    MultiProvider(
      providers: [

        // ProductProvider register kiya gaya hai jisse products API se fetch honge
        ChangeNotifierProvider(
          create: (_) => ProductProvider(apiHelper: ApiHelper()),
        ),

        // CartProvider register kiya gaya hai jisse cart ka data manage hoga
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),

      ],

      // App ka root widget
      child: const MyApp(),
    ),
  );
}


// MyApp ek StatelessWidget hai jo pura application ka UI structure set karta hai
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // MaterialApp app ka main configuration widget hai
    return MaterialApp(

      // Debug banner ko remove karne ke liye
      debugShowCheckedModeBanner: false,

      // App ka title
      title: 'Product App',

      // App ka theme
      theme: ThemeData(primarySwatch: Colors.blue),

      // App ki first screen (home screen)
      home: ProductListScreen(),
    );
  }
}
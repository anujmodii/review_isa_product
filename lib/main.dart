import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:review_isa_product/app/landing_page.dart';
import 'package:review_isa_product/services/auth.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReviewISAProduct',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(73, 128, 3, 1.0),
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}

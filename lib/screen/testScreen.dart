//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:funcart/screen/cartScreen.dart';
import 'package:funcart/screen/homeScreen.dart';
import 'package:funcart/screen/userAccount.dart';
//import 'package:funcart/services/authentication_service.dart';
//import 'package:funcart/services/db_service.dart';

class Test extends StatefulWidget {
  const Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  //State
   final List _pages = [
    MyHomePage(),
    CartScreen(),
    UserAccount()
  ];
  int _currentPage = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      );
  }
}

import 'package:flutter/material.dart';
import 'package:funcart/widgets/productTile.dart';
import '../blocs/productProvider.dart';
//import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = ProductBloc();

  @override
  Widget build(BuildContext context) {
   return WillPopScope(onWillPop: ()async => false,
          child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 10.0),
                child: Text(
                  'Quality Products',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    //color: Color.fromRGBO(253, 253, 253, 2.0),
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Perfect Choice!',
                  style: TextStyle(color: Color(0xFF6F8398), fontSize: 20.0),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 15.0,
                  bottom: 5.0,
                  left: 15.0,
                  right: 15.0,
                ),
                height: 40.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(31, 37, 53, 10.0),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blueGrey),
                ),
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Search',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 15.0),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 2.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: productTile(bloc, context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

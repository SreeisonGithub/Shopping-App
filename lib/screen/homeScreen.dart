import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:funcart/widgets/drawer.dart';
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      labelStyle:
                          TextStyle(color: Colors.white, fontSize: 15.0),
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
              SizedBox(height: 5.0),
              CarouselSlider(
  options: CarouselOptions(height: 150.0),
  items: [1,2].map((i) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Image.asset("assets/images/promo$i.png"), 
          //Center(child: Text('text $i', style: TextStyle(fontSize: 16.0),))
        );
      },
    );
  }).toList(),
),
              Expanded(flex: 2,
               child: Container(
                 height: MediaQuery.of(context).size.height*0.89,
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

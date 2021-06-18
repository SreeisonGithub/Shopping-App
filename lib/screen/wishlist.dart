import 'package:flutter/material.dart';
import 'package:funcart/widgets/drawer.dart';

class Wishlist extends StatefulWidget {
  Wishlist({Key key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
          
          title: Text("Wishlists"),
        ),
        drawer: drawer(),
        resizeToAvoidBottomInset: false,
       
      body: Center(child: Text("login in to see your wishlists")),);
  }
}

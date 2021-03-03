import 'package:flutter/material.dart';
import 'package:funcart/models/productModel.dart';
import 'package:funcart/screen/cartScreen.dart';
import 'package:funcart/screen/homeScreen.dart';
import 'package:funcart/screen/loginScreen.dart';
import 'package:funcart/services/authentication_service.dart';
import 'package:funcart/services/db_service.dart';

class ProductDetailsScreen extends StatelessWidget {
  final bool userSignedIn = false;
  final bool favourite = false;
  final int cartItem = 0;
  final Products product;
  ProductDetailsScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(context),
            Container(
              child: Image.network(product.imageLink),
              height: 186.0,
              width: 186.0,
            ),
            SizedBox(height: 25.0),
            Expanded(child: section(product.description)),
            purchase(context, cartItem, product)
          ],
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  product.brand.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 14),
                ),
                Text(
                  product.name,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F2F3E)),
                ),
              ],
            ),
          ),
          InkWell(
            child: Icon(Icons.shopping_bag),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget section(String des) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 50),
          description(des),
        ],
      ),
    );
  }
}

Widget purchase(BuildContext context, int cartItem, Products product) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          child: Text(
            "ADD TO BAG",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F2F3E)),
          ),
          color: Colors.transparent,
          onPressed: () {
            signedIn(context, cartItem, product);
          },
        ),
        Text(
          product.price,
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w100,
              color: Color(0xFF2F2F3E)),
        )
      ],
    ),
  );
}

Widget description(String des) {
  return Text(
    des,
    maxLines: 5,
    textAlign: TextAlign.justify,
    style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),
  );
}

void signedIn(BuildContext context, int cartItem, Products cartProducts) async {
  List<Products> order = [];
  order.add(cartProducts);
  if (AuthenticationService().getCurrentFirebaseUser() == null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  } else {
    var toFireStore = order[0].toJson();
    //checking users document exist or not
    DbService().dbDecision(toFireStore, cartProducts.name);
    //DbService().addItem(toFireStore);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartScreen()
          //CartScreen(),
          ),
    );
  }
}

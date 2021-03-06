import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:funcart/screen/testScreen.dart';
import 'package:funcart/services/authentication_service.dart';
import 'package:funcart/services/db_service.dart';
import 'package:funcart/services/payment.dart';
import '../widgets/recRoundButton.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  // In the constructor, require a Todo.
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double sum = 34.0;

  double itemPrice;

  final List<Color> signInGradients = [
    Color(0xFFFF9844),
    Color(0xFFFE8853),
    Color(0xFFFD7267),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(context),
            itemLoading(),
            purchase(),
          ],
        ),
      ),
    );
  }

  Widget itemLoading() {
    var loggedIn = AuthenticationService().getCurrentFirebaseUser();
    if (loggedIn == null) {
      return Center(
        child: Text('Sign In to see your orders'),
      );
    }
    String user = loggedIn.email;

    CollectionReference users = FirebaseFirestore.instance.collection(user);
    return Expanded(
      flex: 3,
      child: Container(
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: users.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return Center(
                child: Text('Server Error!'),
              );
            }

            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                //totalSum = totalSum + document.data()['price'];
                // studlist.add(double.parse(document.data()['price']));

                return Container(decoration: BoxDecoration(border: Border.all(color: Colors.black26) ),
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document.data()['name'],
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 22),
                        ),
                        Text(
                          document.data()['brand'],
                        )
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 12, // space between two icons
                      children: <Widget>[
                        Text(
                          '\$' + document.data()['price'],style: TextStyle(fontSize: 20 ),
                        ),
                        InkWell(
                          child: Icon(Icons.close),
                          onTap: () {
                            DbService().deleteItem(document.data()['name']);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget appBar(context) {
    return Container(
      padding: EdgeInsets.all(16),
      //width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Test(),
                ),
              );
            },
          ),
          Container(
            child: Center(
              child: Text(
                "My Order",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F2F3E),
                ),
              ),
            ),
          ),
          Icon(Icons.clear_all)
        ],
      ),
    );
  }

  Widget purchase() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                child: Text(
                  "Total:",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F2F3E)),
                ),
                color: Colors.transparent,
                onPressed: () {},
              ),
              FlatButton(
                child: Text(
                  sum.toString(),
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF2F2F3E)),
                ),
                onPressed: () async {
                  await payment();
                },
              )
            ],
          ),
          roundedRectButton('Checkout', signInGradients, false),
        ],
      ),
    );
  }
}

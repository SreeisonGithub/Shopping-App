import 'package:flutter/material.dart';
import 'package:funcart/screen/testScreen.dart';
import 'package:funcart/services/authentication_service.dart';

Widget navigationDrawer(BuildContext context) {
  String user = 'abc';
  // AuthenticationService().getCurrentFirebaseUser().email.toString();
  return SafeArea(
    child: Container(
      color: Colors.white,
      width: 250.0,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            tileColor: Colors.white,
            title: Text(user),
            onTap: () {
              // Update the state of the app.
              // ...
            //  Navigator.pop(context);
            
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Test(),
                    ),
                  );
            },
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text('Sign Out'),
            onTap: () {
              // Update the state of the app.
              // ...
              AuthenticationService().signOut();
            },
          ),
        ],
      ),
    ),
  );
}

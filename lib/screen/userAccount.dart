import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funcart/screen/testScreen.dart';
import 'package:funcart/services/authentication_service.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import '../widgets/recRoundButton.dart';
import 'loginScreen.dart';

class UserAccount extends StatelessWidget {
  final List<Color> signInGradients = [
    Color(0xFFFF9844),
    Color(0xFFFE8853),
    Color(0xFFFD7267),
  ];

  @override
  Widget build(BuildContext context) {
    final User user = AuthenticationService().getCurrentFirebaseUser();

    if (user == null) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Sign In First!'),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  child: roundedRectButton('Sign In', signInGradients, true),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Center(
                child: UserProfileAvatar(
                  avatarUrl: user.photoURL,
                  onAvatarTap: () {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tapped on avatar'),
                      ),
                    );
                  },
                  avatarSplashColor: Colors.purple,
                  radius: 30,
                  isActivityIndicatorSmall: false,
                  avatarBorderData: AvatarBorderData(
                    borderColor: Colors.black54,
                    borderWidth: 5.0,
                  ),
                ),
              ),
              ListTile(
                title: Center(
                  child: Text(user.email),
                ),
              ),
              ListTile(
                title: Center(
                  child: Text('My Orders'),
                ),
              ),
              ListTile(
                title: Center(
                  child: Text('My Cart'),
                ),
              ),
              RaisedButton(
                child: Text('Sign Out'),
                onPressed: () {
                  AuthenticationService().signOut().then(
                        (_) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Test(),
                          ),
                        ),
                      );
                },
              )
            ],
          ),
        ),
      );
    }
  }
}

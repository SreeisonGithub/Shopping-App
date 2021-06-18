import 'package:flutter/material.dart';
import 'package:funcart/main.dart';
import 'package:funcart/provider/userProvider.dart';
import 'package:funcart/screen/cartScreen.dart';
import 'package:funcart/screen/homeScreen.dart';
import 'package:funcart/screen/loginScreen.dart';
import 'package:funcart/screen/userAccount.dart';
import 'package:funcart/screen/wishlist.dart';
import 'package:funcart/services/authentication_service.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class drawer extends StatelessWidget {
  const drawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double titleFontSize = 15;
    var titleFontWeight = FontWeight.w500;
    double titleIconSize = 25;
    double endIconSize = 12;
    //Color iconColor = Colors.black;

    //UserProvider userProvider = Provider.of<UserProvider>(context);
    // AppProvider appProvider = Provider.of<AppProvider>(context);

    var user = AuthenticationService().getCurrentFirebaseUser();

    return SafeArea(
      child: Container(
        width: 250,
        height: 700,
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: drawerLoginHeader(user, context),
              ),
              SizedBox(height: 5),
              InkWell(
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 12.0, right: 8.0),
                          child: Icon(
                            Icons.home,
                            size: titleIconSize,
                            //color: iconColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, right: 12.0),
                          child: Text(
                            'Home',
                            style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: titleFontWeight),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyApp()));
                  }),
              SizedBox(height: 13.0),
              InkWell(
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 5.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 12.0, right: 8.0),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          size: titleIconSize,
                          //color: iconColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 12.0),
                        child: Text(
                          'My Orders',
                          style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: titleFontWeight),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CartScreen()));
                },
              ),
              SizedBox(height: 13.0),
              InkWell(
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 5.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 12.0, right: 8.0),
                        child: Icon(
                          Icons.bookmark_outline_outlined,
                          size: titleIconSize,
                          //color: iconColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 12.0),
                        child: Text(
                          'My Wishlist',
                          style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: titleFontWeight),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Wishlist()));
                },
              ),
              SizedBox(height: 13.0),
              InkWell(
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 5.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 12.0, right: 8.0),
                        child: Icon(
                          Icons.person,
                          size: titleIconSize,
                          //color: iconColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 8.0,
                          right: 12.0,
                        ),
                        child: Text(
                          'My Account',
                          style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: titleFontWeight),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => UserAccount()),
                  );

                  // LaunchReview.launch(
                  //     androidAppId: "com.skjcorp.hmar_songbook",
                  //     iOSAppId: "000000000");

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (BuildContext context) => name()));
                },
              ),
              SizedBox(height: 13.0),
              InkWell(
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: 5.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 12.0, right: 8.0),
                        child: Icon(
                          Icons.share,
                          size: titleIconSize,
                          //color: iconColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 12.0),
                        child: Text(
                          'Share App',
                          style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: titleFontWeight),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                onTap: () {
                  //as no parameters are provided inside redirect, it will take the package of current project
                  // StoreRedirect.redirect(androidAppId: "com. android. chrome");
                  // StoreRedirect.redirect(
                  //     androidAppId: "com.iyaffle.rangoli", iOSAppId: "585027354");

                  return Share.share(
                      'Enjoy Lyrics on Hmar songbook app install https://hmarsongbook.page.link/get_app');
                },
              ),
              SizedBox(height: 13.0),
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 60.0, right: 60.0),
                child: Divider(
                  color: Colors.black,
                  height: 8.0,
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.copyright,
                      size: 14,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    "FUNCART",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  "v1.0.0",
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  launchurl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget drawerLoginHeader(
    var user,
    BuildContext context,
  ) {
    return Column(
      children: [
        user == null
            ? Center(
                child: CircleAvatar(
                child: Icon(Icons.person, size: 42),
                backgroundColor: Colors.white,
                radius: 40,
              ))
            : Center(
                child: CircleAvatar(
                backgroundImage: user.photoUrl == null
                    ? NetworkImage(
                        "https://placehold.jp/35/9d7b60/ffffff/150x150.png?text=${user.email ?? 'user'}")
                    : NetworkImage(
                        user.photoUrl ?? "https://via.placeholder.com/150"),
                // backgroundImage:
                //     NetworkImage('https://via.placeholder.com/150'),
                backgroundColor: Colors.white,
                radius: 30,
              )),
        SizedBox(height: 20),
        user == null
            ? InkWell(
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                onTap: () {
                  // poping the drawer
                  Navigator.of(context).pop();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                },
              )
            : InkWell(
                child: Center(
                  child: Text(
                    " ${user.email}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      //appProvider.getTheme ==true?Colors.white:Colors.white,
                    ),
                  ),
                ),
                onTap: () {
                  if (user == null) {
                    Navigator.of(context).pop();
                  }
                },
              ),
        SizedBox(height: 10.0),
        user != null
            ? InkWell(
                child: Center(
                    child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
                onTap: () {
                  //AppUtils.showLoading(context);
                  AuthenticationService()
                      .signOut()
                      .then((_) => Navigator.pop(context));
                  //userProvider.signOutUser();

//AppUtils.showSnackBar(context, "Logged out successfully!");
                  Navigator.pop(context);
                },
              )
            : Container()
      ],
    );
  }
}

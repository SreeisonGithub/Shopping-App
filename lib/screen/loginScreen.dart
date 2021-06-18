import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funcart/main.dart';
import 'package:funcart/screen/homeScreen.dart';
import 'package:funcart/screen/testScreen.dart';
import 'package:funcart/services/authentication_service.dart';
import 'package:funcart/ui/FadeAnimation.dart';
import '../widgets/recRoundButton.dart';
import 'signUpScreen.dart';
import '../blocs/bloc.dart';

class LoginScreen extends StatelessWidget {
  final bloc = Bloc();

  final List<Color> signInGradients = [
    Color(0xFFFF9844),
    Color(0xFFFE8853),
    Color(0xFFFD7267),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.blue[900],
                Colors.blue[800],
                Colors.blue[400]
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[ appBar(context),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                      1,
                      Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                        1.3,
                        Text(
                          "Welcome Back",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: emailField(bloc)
                                      // TextField(
                                      //   decoration: InputDecoration(
                                      //       hintText: "Email",
                                      //       hintStyle:
                                      //           TextStyle(color: Colors.grey),
                                      //       border: InputBorder.none),
                                      // ),
                                      ),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: passwordField(bloc)
                                      // TextField(
                                      //   decoration: InputDecoration(
                                      //       hintText: "Password",
                                      //       hintStyle:
                                      //           TextStyle(color: Colors.grey),
                                      //       border: InputBorder.none),
                                      // ),
                                      ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          InkWell(
                                child: FadeAnimation(
                                1.5,
                                Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.grey),
                                ),),onTap:() {
                    AuthenticationService()
                           .forgotPasswordEmail(bloc.emailController.value);
                     },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          FadeAnimation(
                            1.6,
                            StreamBuilder(
                                stream: bloc.submitValid,
                                builder: (context, snapshot) {
                                  return GestureDetector(
                                    child: Container(
                                      height: 40,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.orange[900],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      await AuthenticationService()
                                          .signIn(bloc.emailController.value,
                                              bloc.passwordController.value)
                                          .then(
                                            (_) => //Navigator.pop(context) );
                                                Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MyApp(),
                                              ),
                                            ),
                                          );
                                    },
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                     InkWell(
                       child: Text(
                           'Create an Account',),
                       onTap: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => SignUpScreen(),
                           ),
                         );
                       },
                     ),
                          SizedBox(
                            height: 15,
                          ),
          
                          FadeAnimation(
                            1.7,
                            Text(
                              "Continue with social media",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: FadeAnimation(
                                  1.8,
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.blue),
                                    child: Center(
                                      child: Text(
                                        "Facebook",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: FadeAnimation(
                                  1.9,
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.black),
                                    child: Center(
                                      child: Text(
                                        "Google",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget submitButton(Bloc bloc) {
    List<Color> signInGradients = [
      Color(0xFFFF9844),
      Color(0xFFFE8853),
      Color(0xFFFD7267),
    ];

    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: () async {
            await AuthenticationService()
                .signIn(
                    bloc.emailController.value, bloc.passwordController.value)
                .then(
                  (_) => //Navigator.pop(context) );
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  ),
                );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: ShapeDecoration(
              shape: CircleBorder(),
              gradient: LinearGradient(
                colors: signInGradients,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 40,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

Widget emailField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.email,
    builder: (context, snapshot) {
      return TextField(
        onChanged: bloc.changeEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "JohnDoe@example.com",
            hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14),
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 2.0),
              child: Icon(Icons.email),
            ),
            errorText: snapshot.error),
      );
    },
  );
}

Widget passwordField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.password,
    builder: (context, snapshot) {
      return TextField(
        onChanged: bloc.changePassword,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "123@abc",
            hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14),
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 2.0),
              child: Icon(Icons.lock),
            ),
            errorText: snapshot.error),
        obscureText: true,
      );
    },
  );
}


  Widget appBar(context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: Icon(Icons.arrow_back_ios,color:Colors.white),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

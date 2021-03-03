import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funcart/screen/testScreen.dart';
import 'package:funcart/services/authentication_service.dart';
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
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 150),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0, bottom: 26.0),
                  child: emailField(bloc),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0, bottom: 16.0),
                  child: passwordField(bloc),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: submitButton(bloc),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    child: roundedRectButton(
                        'Create an Account', signInGradients, true),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                  ),
                ),
                /* InkWell(
                  child: roundedRectButton('Forgot Password', signInGradients, true),
                  onTap: () {
                    AuthenticationService()
                        .forgotPasswordEmail(bloc.emailController.value);
                  },
                ),*/
              ],
            ),
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
                      builder: (context) => Test(),
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
      return Material(
        elevation: 10.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30.0))),
        child: Padding(
          padding:
              EdgeInsets.only(left: 40.0, right: 20.0, top: 10.0, bottom: 10.0),
          child: TextField(
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
          ),
        ),
      );
    },
  );
}

Widget passwordField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.password,
    builder: (context, snapshot) {
      return Material(
        elevation: 10.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30.0))),
        child: Padding(
          padding:
              EdgeInsets.only(left: 40.0, right: 20.0, top: 10.0, bottom: 10.0),
          child: TextField(
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
          ),
        ),
      );
    },
  );
}

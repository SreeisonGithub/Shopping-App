import 'package:flutter/material.dart';
import 'package:funcart/screen/testScreen.dart';
import 'package:funcart/services/authentication_service.dart';
import '../blocs/bloc.dart';
import '../widgets/recRoundButton.dart';


class SignUpScreen extends StatelessWidget {
  final List<Color> signInGradients = [
    Color(0xFFFF9844),
    Color(0xFFFE8853),
    Color(0xFFFD7267),
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = Bloc();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 200),
              Padding(
                padding: const EdgeInsets.only(right: 32.0, bottom: 26.0),
                child: emailField(bloc),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 32.0, bottom: 16.0),
                child: passwordField(bloc),
              ),
              Container(
                margin: EdgeInsets.only(top: 25.0),
              ),
              submitButton(bloc),
            ],
          ),
        ),
      ),
    );
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
            padding: EdgeInsets.only(
                left: 40.0, right: 20.0, top: 10.0, bottom: 10.0),
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
            padding: EdgeInsets.only(
                left: 40.0, right: 20.0, top: 10.0, bottom: 10.0),
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

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return InkWell(
          child: roundedRectButton('Sign Up', signInGradients, true),
          onTap: () async {
            await AuthenticationService()
                .signUp(
                    bloc.emailController.value, bloc.passwordController.value)
                .then(
                  (_) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Test(),
                    ),
                  ),
                );
          },
        );
        /*RaisedButton(
          // if it has a null value, it is disabled by default
          child: Text('SignUp'),
          color: Colors.redAccent,
          //if both fields are valid, button enabled
          //to do
          onPressed: () async {
            await AuthenticationService()
                .signUp(
                    bloc.emailController.value, bloc.passwordController.value)
                .then(
                  (_) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  ),
                );
          },
        );*/
      },
    );
  }
}


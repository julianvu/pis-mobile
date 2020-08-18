import 'package:flutter/material.dart';

class LoginSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          signUpButton(),
          Padding(padding: const EdgeInsets.all(20.0)),
          loginButton(context)
        ],
      ),
    );
  }

  Widget signUpButton() {
    return RaisedButton(
      onPressed: () {},
      child: Text("Sign Up"),
      color: Colors.blue,
    );
  }

  Widget loginButton(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.pushNamed(context, "/login");
      },
      child: Text("Log In"),
      color: Colors.green,
    );
  }
}

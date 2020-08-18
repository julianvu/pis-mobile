import 'package:flutter/material.dart';
import 'package:pis_mobile/src/bloc/login_bloc.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = Provider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        child: Column(
          children: [
            nameField(bloc),
            emailField(bloc),
            passwordField(bloc),
            passwordConfirmField(bloc),
            submitButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget nameField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.name,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: bloc.changeName,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Name",
              labelText: "Name",
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );
  }

  Widget emailField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "you@example.com",
              labelText: "Email Address",
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );
  }

  Widget passwordField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: bloc.changePassword,
            obscureText: true,
            decoration: InputDecoration(
                hintText: "password",
                labelText: "Password",
                errorText: snapshot.error),
          ),
        );
      },
    );
  }

  Widget passwordConfirmField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordConfirm,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: bloc.changePasswordConfirm,
            obscureText: true,
            decoration: InputDecoration(
                hintText: "password",
                labelText: "Confirm Password",
                errorText: snapshot.error),
          ),
        );
      },
    );
  }

  Widget submitButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.signupValid,
      builder: (context, snapshot) {
        return RaisedButton(
          onPressed: snapshot.hasData ? bloc.signUp : null,
          child: Text("Sign Up"),
          color: Colors.blue,
        );
      },
    );
  }
}

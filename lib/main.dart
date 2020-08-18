import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pis_mobile/src/bloc/login_bloc.dart';
import 'package:pis_mobile/src/view/login_screen.dart';
import 'package:pis_mobile/src/view/login_selection.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Personnel Information System"),
          ),
          body: LoginSelection(),
        ),
      );
    } else if (settings.name == "/login") {
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Personnel Information System"),
          ),
          body: LoginScreen(),
        ),
      );
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = Firestore.instance.collection("users");
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();

  void createNewUser() async {
    AuthResult result = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text, password: password.text);
    users
        .document(result.user.uid)
        .setData({"name": nameController.text, "email": emailController.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: password,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
            ),
            RaisedButton(
              onPressed: createNewUser,
              child: Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}

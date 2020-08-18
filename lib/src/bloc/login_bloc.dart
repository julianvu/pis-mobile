import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pis_mobile/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc extends Object with Validators {
  final BehaviorSubject<String> _email = BehaviorSubject();
  final BehaviorSubject<String> _password = BehaviorSubject();

  // Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  // Retrieve data from stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  void submit() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    final validEmail = _email.value;
    final validPassword = _password.value;
    AuthResult authResult = await firebaseAuth.signInWithEmailAndPassword(
        email: validEmail, password: validPassword);
    if (authResult.user != null) {
      print("Login Successful");
      print("UserID: ${authResult.user.uid}");
    } else {
      print("Login FAILED");
    }
    print("Email is $validEmail");
    print("Password is $validPassword");
  }

  void dispose() {
    _email.close();
    _password.close();
  }
}

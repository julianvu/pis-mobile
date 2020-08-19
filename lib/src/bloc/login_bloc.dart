import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pis_mobile/models/user.dart';
import 'package:pis_mobile/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LoginBloc extends Object with Validators {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final BehaviorSubject<String> _name = BehaviorSubject();
  final BehaviorSubject<String> _email = BehaviorSubject();
  final BehaviorSubject<String> _password = BehaviorSubject();
  final BehaviorSubject<String> _passwordConfirm = BehaviorSubject();

  // Change data
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changePasswordConfirm => _passwordConfirm.sink.add;

  // Retrieve data from stream
  Stream<String> get name => _name.stream;
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<String> get passwordConfirm =>
      _passwordConfirm.stream.transform(validatePassword).doOnData(
        (event) {
          if (_password.value.compareTo(event) != 0) {
            _passwordConfirm.sink.addError("Passwords do not match");
          }
        },
      );

  Stream<bool> get signupValid => Rx.combineLatest3(
      email, password, passwordConfirm, (a, b, c) => (b.compareTo(c) == 0));
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  void signUp() async {
    try {
      AuthResult result = await firebaseAuth.createUserWithEmailAndPassword(
          email: _email.value, password: _password.value);
      User user = User(
        uid: result.user.uid,
        name: _name.value,
        email: _email.value,
      );

      CollectionReference users = Firestore.instance.collection("users");
      users.document(user.uid).setData(user.toMap());
    } on AuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  void submit() async {
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
    _name.close();
    _email.close();
    _password.close();
    _passwordConfirm.close();
  }
}

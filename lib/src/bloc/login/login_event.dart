import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  LoginEmailChanged({this.email});

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class LoginWithEmailAndPasswordPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmailAndPasswordPressed({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}

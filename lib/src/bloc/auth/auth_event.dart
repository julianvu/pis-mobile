import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pis_mobile/models/user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Fired just after the app is launched
class AppLoaded extends AuthEvent {}

/// Fired when a user has successfully logged in
class UserLoggedIn extends AuthEvent {
  final User user;

  UserLoggedIn({@required this.user});

  @override
  List<Object> get props => [user];
}

/// Fired when user has logged out
class UserLoggedOut extends AuthEvent {}

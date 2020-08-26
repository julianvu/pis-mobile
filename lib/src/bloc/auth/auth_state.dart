import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pis_mobile/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthNotAuthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure({@required this.message});

  @override
  List<Object> get props => [message];
}

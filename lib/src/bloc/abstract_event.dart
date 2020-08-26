import 'package:equatable/equatable.dart';

abstract class AbstractEvent extends Equatable {
  AbstractEvent();
  @override
  List<Object> get props => [];
  dynamic name();
}

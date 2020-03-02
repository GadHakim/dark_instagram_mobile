import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class FetchHomeEvent extends HomeEvent {
  FetchHomeEvent();

  @override
  List<Object> get props => null;
}

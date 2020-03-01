import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {}

class FetchGetNewsEvent extends NewsEvent {
  FetchGetNewsEvent();

  @override
  List<Object> get props => null;
}

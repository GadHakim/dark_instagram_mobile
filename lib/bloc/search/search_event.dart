import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class FetchGetAllPostsEvent extends SearchEvent {
  FetchGetAllPostsEvent();

  @override
  List<Object> get props => null;
}

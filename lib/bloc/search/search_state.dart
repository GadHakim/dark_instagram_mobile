import 'package:equatable/equatable.dart';
import 'package:instagram/ui/pages/search_page.dart';
import 'package:meta/meta.dart';

abstract class SearchState extends Equatable {}

class SearchInitialState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadingState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadedState extends SearchState {
  final List<SearchItem> searchList;

  SearchLoadedState({this.searchList});

  @override
  List<Object> get props => [searchList];
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

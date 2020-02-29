import 'package:equatable/equatable.dart';
import 'package:instagram/data/models/people_model.dart';
import 'package:instagram/data/models/subscribers_posts_model.dart';
import 'package:meta/meta.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  final PeopleModel peopleModel;
  final SubscribersPostsModel subscribersPostsModel;

  HomeLoadedState({
    @required this.peopleModel,
    @required this.subscribersPostsModel,
  });

  @override
  List<Object> get props => [PeopleModel];
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

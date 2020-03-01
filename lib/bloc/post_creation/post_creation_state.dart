import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PostCreationState extends Equatable {}

class PostCreationInitialState extends PostCreationState {
  @override
  List<Object> get props => [];
}

class PostCreationLoadingState extends PostCreationState {
  @override
  List<Object> get props => [];
}

class PostCreationLoadedState extends PostCreationState {
  PostCreationLoadedState();

  @override
  List<Object> get props => [];
}

class PostCreationErrorState extends PostCreationState {
  final String message;

  PostCreationErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

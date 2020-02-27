import 'package:equatable/equatable.dart';
import 'package:instagram/data/models/sign_in_model.dart';
import 'package:meta/meta.dart';

abstract class SignInState extends Equatable {}

class SignInInitialState extends SignInState {
  @override
  List<Object> get props => [];
}

class ArticleLoadingState extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoadedState extends SignInState {
  final SignInModel signInModel;

  SignInLoadedState({@required this.signInModel});

  @override
  List<Object> get props => [signInModel];
}

class SignInErrorState extends SignInState {
  final String message;

  SignInErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

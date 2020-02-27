import 'package:equatable/equatable.dart';
import 'package:instagram/data/models/sign_up_model.dart';
import 'package:meta/meta.dart';

abstract class SignUpState extends Equatable {}

class SignUpInitialState extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoadingState extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoadedState extends SignUpState {
  final SignUpModel signUpModel;

  SignUpLoadedState({@required this.signUpModel});

  @override
  List<Object> get props => [signUpModel];
}

class SignUpErrorState extends SignUpState {
  final String message;

  SignUpErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

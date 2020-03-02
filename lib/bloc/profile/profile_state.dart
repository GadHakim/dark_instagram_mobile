import 'package:equatable/equatable.dart';
import 'package:instagram/data/models/profile_model.dart';
import 'package:meta/meta.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitialState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadedState extends ProfileState {
  final ProfileModel profileModel;

  ProfileLoadedState({@required this.profileModel});

  @override
  List<Object> get props => [profileModel];
}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

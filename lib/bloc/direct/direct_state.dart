import 'package:equatable/equatable.dart';
import 'package:instagram/data/models/direct_model.dart';
import 'package:meta/meta.dart';

abstract class DirectState extends Equatable {}

class DirectInitialState extends DirectState {
  @override
  List<Object> get props => [];
}

class DirectLoadingState extends DirectState {
  @override
  List<Object> get props => [];
}

class DirectLoadedState extends DirectState {
  final DirectModel directModel;

  DirectLoadedState({@required this.directModel});

  @override
  List<Object> get props => [directModel];
}

class DirectErrorState extends DirectState {
  final String message;

  DirectErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

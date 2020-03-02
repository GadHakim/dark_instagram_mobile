import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class FetchGetProfileEvent extends ProfileEvent {
  @override
  List<Object> get props => null;
}

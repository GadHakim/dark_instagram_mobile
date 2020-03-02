import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {}

class FetchSignUpEvent extends SignUpEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  FetchSignUpEvent(
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  );

  @override
  List<Object> get props => null;
}

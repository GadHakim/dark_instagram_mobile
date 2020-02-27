import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {}

class FetchSignInEvent extends SignInEvent {
  final String email;
  final String password;

  FetchSignInEvent(this.email, this.password);

  @override
  List<Object> get props => null;
}

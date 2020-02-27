import 'package:bloc/bloc.dart';
import 'package:instagram/bloc/sign_in/sign_in_event.dart';
import 'package:instagram/bloc/sign_in/sign_in_state.dart';
import 'package:instagram/data/models/http_error_model.dart';
import 'package:instagram/data/models/sign_in_model.dart';
import 'package:instagram/data/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository repository;

  SignInBloc({@required this.repository});

  @override
  SignInState get initialState => SignInInitialState();

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is FetchSignInEvent) {
      yield SignInLoadingState();
      try {
        SignInModel signInModel = await repository.signIn(
          event.email,
          event.password,
        );
        yield SignInLoadedState(signInModel: signInModel);
      } catch (error) {
        if (error is HttpError) {
          yield SignInErrorState(message: error.message);
        } else {
          yield SignInErrorState(message: 'Unknow Error');
        }
      }
    }
  }
}

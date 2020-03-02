import 'package:bloc/bloc.dart';
import 'package:instagram/bloc/sign_up/sign_up_event.dart';
import 'package:instagram/bloc/sign_up/sign_up_state.dart';
import 'package:instagram/data/models/http_error_model.dart';
import 'package:instagram/data/models/sign_up_model.dart';
import 'package:instagram/data/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository repository;

  SignUpBloc({@required this.repository});

  @override
  SignUpState get initialState => SignUpInitialState();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is FetchSignUpEvent) {
      yield SignUpLoadingState();
      try {
        SignUpModel signUpModel = await repository.signUp(
          event.firstName,
          event.lastName,
          event.email,
          event.password,
        );
        yield SignUpLoadedState(signUpModel: signUpModel);
      } catch (error) {
        if (error is HttpError) {
          yield SignUpErrorState(message: error.message);
        } else {
          yield SignUpErrorState(message: 'Unknow Error');
        }
      }
    }
  }
}

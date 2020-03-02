import 'package:bloc/bloc.dart';
import 'package:instagram/data/models/http_error_model.dart';
import 'package:instagram/data/models/profile_model.dart';
import 'package:instagram/data/repositories/profile_repository.dart';
import 'package:meta/meta.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({@required this.repository});

  @override
  ProfileState get initialState => ProfileInitialState();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchGetProfileEvent) {
      yield ProfileLoadingState();
      try {
        ProfileModel profileModel = await repository.getProfile();
        yield ProfileLoadedState(profileModel: profileModel);
      } catch (error) {
        if (error is HttpError) {
          yield ProfileErrorState(message: error.message);
        } else {
          yield ProfileErrorState(message: 'Unknow Error');
        }
      }
    }
  }
}

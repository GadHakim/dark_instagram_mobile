import 'package:bloc/bloc.dart';
import 'package:instagram/data/models/http_error_model.dart';
import 'package:instagram/data/models/direct_model.dart';
import 'package:instagram/data/repositories/direct_repository.dart';
import 'package:meta/meta.dart';

import 'direct_event.dart';
import 'direct_state.dart';

class DirectBloc extends Bloc<DirectEvent, DirectState> {
  final DirectRepository repository;

  DirectBloc({@required this.repository});

  @override
  DirectState get initialState => DirectInitialState();

  @override
  Stream<DirectState> mapEventToState(DirectEvent event) async* {
    if (event is FetchGetDirectEvent) {
      yield DirectLoadingState();
      try {
        DirectModel directModel = await repository.getDirect();
        yield DirectLoadedState(directModel: directModel);
      } catch (error) {
        if (error is HttpError) {
          yield DirectErrorState(message: error.message);
        } else {
          yield DirectErrorState(message: 'Unknow Error');
        }
      }
    }
  }
}

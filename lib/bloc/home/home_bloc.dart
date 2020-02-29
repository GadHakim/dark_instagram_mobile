import 'package:bloc/bloc.dart';
import 'package:instagram/bloc/home/home_event.dart';
import 'package:instagram/bloc/home/home_state.dart';
import 'package:instagram/data/models/all_post_model.dart';
import 'package:instagram/data/models/http_error_model.dart';
import 'package:instagram/data/models/people_model.dart';
import 'package:instagram/data/repositories/people_repository.dart';
import 'package:instagram/data/repositories/post_repository.dart';
import 'package:meta/meta.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PeopleRepository peopleRepository;
  final PostRepository postRepository;

  HomeBloc({
    @required this.peopleRepository,
    @required this.postRepository,
  });

  @override
  HomeState get initialState => HomeInitialState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchHomeEvent) {
      yield HomeLoadingState();
      try {
        PeopleModel peopleModel = await peopleRepository.getPeople();
        AllPostModel allPostModel = await postRepository.getAllPost();
        yield HomeLoadedState(
          peopleModel: peopleModel,
          allPostModel: allPostModel,
        );
      } catch (error) {
        if (error is HttpError) {
          yield HomeErrorState(message: error.message);
        } else {
          yield HomeErrorState(message: 'Unknow Error');
        }
      }
    }
  }
}

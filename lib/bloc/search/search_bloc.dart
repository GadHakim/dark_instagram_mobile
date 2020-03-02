import 'package:bloc/bloc.dart';
import 'package:instagram/bloc/search/search_event.dart';
import 'package:instagram/bloc/search/search_state.dart';
import 'package:instagram/data/models/all_post_model.dart';
import 'package:instagram/data/models/http_error_model.dart';
import 'package:instagram/data/repositories/post_repository.dart';
import 'package:instagram/ui/pages/search_page.dart';
import 'package:meta/meta.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PostRepository repository;

  SearchBloc({@required this.repository});

  @override
  SearchState get initialState => SearchInitialState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is FetchGetAllPostsEvent) {
      yield SearchLoadingState();
      try {
        AllPostModel allPost = await repository.getAllPost();
        List<SearchItem> searchList = SearchItem.fromModel(allPost);
        yield SearchLoadedState(searchList: searchList);
      } catch (error) {
        if (error is HttpError) {
          yield SearchErrorState(message: error.message);
        } else {
          yield SearchErrorState(message: 'Unknow Error');
        }
      }
    }
  }
}

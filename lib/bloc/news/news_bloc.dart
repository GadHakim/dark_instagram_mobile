import 'package:bloc/bloc.dart';
import 'package:instagram/bloc/news/news_event.dart';
import 'package:instagram/data/models/http_error_model.dart';
import 'package:instagram/data/models/people_model.dart';
import 'package:instagram/data/repositories/people_repository.dart';
import 'package:instagram/ui/pages/news_page.dart';
import 'package:meta/meta.dart';

import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final PeopleRepository repository;

  NewsBloc({@required this.repository});

  @override
  NewsState get initialState => NewsInitialState();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchGetNewsEvent) {
      yield NewsLoadingState();
      try {
        PeopleModel peopleModel = await repository.getPeople();
        List<NewsItem> news = [];
        news.add(RecommendationItem());
        news.addAll(PersonItem.create(peopleModel));
        yield NewsLoadedState(news: news);
      } catch (error) {
        if (error is HttpError) {
          yield NewsErrorState(message: error.message);
        } else {
          yield NewsErrorState(message: 'Unknow Error');
        }
      }
    }
  }
}

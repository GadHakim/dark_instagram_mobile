import 'package:bloc/bloc.dart';
import 'package:instagram/bloc/news/news_event.dart';
import 'package:instagram/data/models/http_error_model.dart';
import 'package:instagram/data/models/people_model.dart';
import 'package:instagram/data/repositories/people_repository.dart';
import 'package:instagram/data/repositories/subscribers_repository.dart';
import 'package:instagram/ui/pages/news_page.dart';
import 'package:meta/meta.dart';

import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final PeopleRepository peopleRepository;
  final SubscribersRepository subscribersRepository;

  NewsBloc({
    @required this.peopleRepository,
    @required this.subscribersRepository,
  });

  @override
  NewsState get initialState => NewsInitialState();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchGetNewsEvent) {
      yield NewsLoadingState();
      try {
        PeopleModel peopleModel = await peopleRepository.getPeople();
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
    } else if (event is FetchNewsSubscribeEvent) {
      yield NewsLoadingState();
      try {
        await subscribersRepository.subscribe(event.subscriberId);
        yield NewsSubscribeState();
      } catch (error) {
        if (error is HttpError) {
          yield NewsErrorState(message: error.message);
        } else {
          yield NewsErrorState(message: 'Unknow Error');
        }
      }
    } else if (event is FetchNewsUnsubscribeEvent) {
      yield NewsLoadingState();
      try {
        await subscribersRepository.unsubscribe(event.subscriberId);
        yield NewsUnsubscribeState();
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

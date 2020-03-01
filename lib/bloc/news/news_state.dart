import 'package:equatable/equatable.dart';
import 'package:instagram/ui/pages/news_page.dart';
import 'package:meta/meta.dart';

abstract class NewsState extends Equatable {}

class NewsInitialState extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoadingState extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoadedState extends NewsState {
  final List<NewsItem> news;

  NewsLoadedState({@required this.news});

  @override
  List<Object> get props => [news];
}

class NewsErrorState extends NewsState {
  final String message;

  NewsErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {}

class FetchGetNewsEvent extends NewsEvent {
  FetchGetNewsEvent();

  @override
  List<Object> get props => null;
}

class FetchNewsSubscribeEvent extends NewsEvent {
  final int subscriberId;

  FetchNewsSubscribeEvent(this.subscriberId);

  @override
  List<Object> get props => null;
}

class FetchNewsUnsubscribeEvent extends NewsEvent {
  final int subscriberId;

  FetchNewsUnsubscribeEvent(this.subscriberId);

  @override
  List<Object> get props => null;
}

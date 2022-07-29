part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsLoadingState extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoadedState extends NewsState {
  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;

  NewsLoadedState(this.count, this.next, this.previous, this.results);

  @override
  // TODO: implement props
  List<Object?> get props => [count, next, previous, results];
}

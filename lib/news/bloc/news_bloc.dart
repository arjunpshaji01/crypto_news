import 'package:bloc/bloc.dart';
import 'package:crypto_news/news/model/news_model.dart';
import 'package:equatable/equatable.dart';
import 'package:crypto_news/news/data/news_service.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  ///api services class object
  final NewsService _newsService;

  NewsBloc(this._newsService) : super(NewsLoadingState()) {
    on<LoadApiEvent>((event, emit) async {
      final CryptoNews = await _newsService.getCryptoNews();
      emit(NewsLoadedState(CryptoNews.count, CryptoNews.next,
          CryptoNews.previous, CryptoNews.results));
    });
  }
}

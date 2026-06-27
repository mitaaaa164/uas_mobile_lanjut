import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/domain/news_repository.dart';

// States
abstract class NewsState {}
class NewsInitial extends NewsState {}
class NewsLoading extends NewsState {}
class NewsSuccess extends NewsState {
  final List<Article> articles;
  NewsSuccess(this.articles);
}
class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}

// Cubit
class NewsCubit extends Cubit<NewsState> {
  final NewsRepository repository;

  NewsCubit(this.repository) : super(NewsInitial());

  Future<void> getNews() async {
    emit(NewsLoading());
    try {
      final articles = await repository.fetchTopNews();
      emit(NewsSuccess(articles));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
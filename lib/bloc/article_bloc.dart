import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_skuad/models/article_model.dart';
import 'package:test_skuad/repositories/article_repositories.dart';
import 'package:test_skuad/services/db_service.dart';
import 'article_event.dart';
import 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository _articleRepository;
  final DbService _dbService;

  ArticleBloc(this._articleRepository, this._dbService) : super(ArticleInitial()) {
    on<FetchArticles>((event, emit) async {
      emit(ArticleLoading());
      try {
        final articles = await _articleRepository.fetchArticles();
        // Insert fetched articles into the local database
        for (var article in articles) {
          await _dbService.insertArticle(article);
        }
        emit(ArticleLoaded(articles));
      } catch (e) {
        print('Error fetching from API: $e');
        // If there's an error, load articles from the local database
        try {
          final localArticles = await _dbService.getArticles();
          emit(ArticleLoaded(localArticles));
        } catch (dbError) {
          print('Error fetching from DB: $dbError');
          emit(ArticleError(e.toString()));
        }
      }
    });
  }

  // New method to get articles from the database
  Future<List<Article>> getArticlesFromDb() async {
    return await _dbService.getArticles();
  }
}


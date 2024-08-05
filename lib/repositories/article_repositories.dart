import 'package:test_skuad/models/article_model.dart';


import '../services/api_service.dart';

class ArticleRepository {
  final ApiService _apiService;

  ArticleRepository(this._apiService);

  Future<List<Article>> fetchArticles() async {
    return await _apiService.fetchArticles();
  }
}


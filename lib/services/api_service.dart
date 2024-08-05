import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_skuad/models/article_model.dart';

class ApiService {
  static const String url = 'http://hn.algolia.com/api/v1/search_by_date?query=mobile';
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Article>> fetchArticles() async {
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List articles = json.decode(response.body)['hits'];
      return articles.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}

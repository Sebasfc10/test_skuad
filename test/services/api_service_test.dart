import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_skuad/models/article_model.dart';
import 'package:test_skuad/services/api_service.dart';
import 'api_service_test.mocks.dart';

// Genera las clases mock
@GenerateMocks([http.Client])
void main() {
  group('ApiService', () {
    test('fetchArticles returns a list of articles if the http call completes successfully', () async {
      final client = MockClient();
      final apiService = ApiService(client: client);

      // Configura el mock para que devuelva una respuesta exitosa
      final mockResponse = json.encode({
        "exhaustiveNbHits": false,
        "exhaustiveTypo": false,
        "hits": [
          {
            "story_title": "Article 1",
            "author": "Author 1",
            "created_at": "2024-08-01T00:00:00Z"
          },
          {
            "story_title": "Article 2",
            "author": "Author 2",
            "created_at": "2024-08-02T00:00:00Z"
          },
        ]
      });

      // Asegúrate de que el método `get` del cliente mock devuelva una respuesta adecuada
      when(client.get(Uri.parse(ApiService.url))).thenAnswer((_) async {
  print('Mock client called');
  return http.Response(mockResponse, 200);
});


      // Llama al método fetchArticles
      final articles = await apiService.fetchArticles();

      // Verifica el resultado
      expect(articles, isA<List<Article>>());
      expect(articles.length, 2);
      expect(articles[0].title, 'Article 1');
      expect(articles[0].author, 'Author 1');
      expect(articles[0].createdAt, DateTime.parse('2024-08-01T00:00:00Z'));
      expect(articles[1].title, 'Article 2');
      expect(articles[1].author, 'Author 2');
      expect(articles[1].createdAt, DateTime.parse('2024-08-02T00:00:00Z'));
    });
  });
}

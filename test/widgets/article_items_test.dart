import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test_skuad/bloc/article_bloc.dart';
import 'package:test_skuad/bloc/article_event.dart';
import 'package:test_skuad/bloc/article_state.dart';
import 'package:test_skuad/models/article_model.dart';
import 'package:test_skuad/widgets/article_items.dart';

// Mock del ArticleBloc
class MockArticleBloc extends MockBloc<ArticleEvent, ArticleState> implements ArticleBloc {}

void main() {
  group('ArticleListScreen', () {


   testWidgets('ArticleItem displays article data correctly', (WidgetTester tester) async {
    // Define los datos del artículo
    final article = Article(
      title: 'Sample Article Title',
      author: 'John Doe',
      createdAt: DateTime.now(),
    );

    // Crea el widget ArticleItem
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ArticleItem(article, key: Key('article_item_key')),
        ),
      ),
    );

    // Verifica que el título del artículo se muestra
    expect(find.text('Sample Article Title'), findsOneWidget);

    // Verifica que el autor del artículo se muestra
    expect(find.text('by: John Doe'), findsOneWidget);

    // Verifica que la fecha del artículo se muestra
    expect(find.text('${article.createdAt.toLocal()}'), findsOneWidget);
  });


    
  });
}

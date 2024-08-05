import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart'; 
import 'package:test_skuad/bloc/article_bloc.dart';
import 'package:test_skuad/bloc/article_event.dart';
import 'package:test_skuad/bloc/article_state.dart';
import 'package:test_skuad/screens/article_list_screen.dart';


// Mock del ArticleBloc
class MockArticleBloc extends MockBloc<ArticleEvent, ArticleState> implements ArticleBloc {}

void main() {
  group('ArticleListScreen', () {
    late MockArticleBloc mockArticleBloc;

    setUp(() {
      mockArticleBloc = MockArticleBloc();
    });

    testWidgets('displays AppBar with correct title', (WidgetTester tester) async {
      // Configura el estado inicial
      whenListen(
        mockArticleBloc,
        Stream.fromIterable([ArticleInitial()]),
        initialState: ArticleInitial(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ArticleBloc>(
            create: (context) => mockArticleBloc,
            child: ArticleListScreen(),
          ),
        ),
      );

      // Verifica que el AppBar con el título correcto esté presente
      expect(find.byKey(Key('app_bar_title')), findsOneWidget);
    });

    testWidgets('displays CircularProgressIndicator when ArticleLoading', (WidgetTester tester) async {
      whenListen(
        mockArticleBloc,
        Stream.fromIterable([ArticleLoading()]),
        initialState: ArticleInitial(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ArticleBloc>(
            create: (context) => mockArticleBloc,
            child: ArticleListScreen(),
          ),
        ),
      );

      expect(find.byKey(Key('loading_indicator')), findsOneWidget);
    });

    testWidgets('Shows loading indicator on initial state', (WidgetTester tester) async {
      // Usa bloc_test para definir el comportamiento del bloc
      whenListen(
        mockArticleBloc,
        Stream.fromIterable([ArticleInitial()]),
        initialState: ArticleInitial(),
      );

      // Construye el widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ArticleBloc>(
            create: (_) => mockArticleBloc,
            child: ArticleListScreen(),
          ),
        ),
      );

      // Verifica que el indicador de carga está presente
      expect(find.byKey(Key('loading_indicator')), findsOneWidget);
    });


  });
}

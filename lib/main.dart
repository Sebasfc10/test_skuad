import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_skuad/bloc/article_bloc.dart';
import 'package:test_skuad/repositories/article_repositories.dart';
import 'package:test_skuad/services/api_service.dart';
import 'package:test_skuad/services/db_service.dart';
import 'package:test_skuad/screens/article_list_screen.dart';

void main() {
  final apiService = ApiService();
  final dbService = DbService();
  final articleRepository = ArticleRepository(apiService);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ArticleBloc(articleRepository, dbService),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ArticleListScreen(),
    );
  }
}

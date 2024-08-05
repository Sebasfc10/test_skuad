import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_skuad/bloc/article_bloc.dart';
import 'package:test_skuad/bloc/article_event.dart';
import 'package:test_skuad/bloc/article_state.dart';
import 'package:test_skuad/models/article_model.dart';
import 'package:test_skuad/widgets/article_items.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News', key: Key('app_bar_title')),
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleInitial) {
            BlocProvider.of<ArticleBloc>(context).add(FetchArticles());
            return Center(child: CircularProgressIndicator(key: Key('loading_indicator')));
          } else if (state is ArticleLoading) {
            return Center(child: CircularProgressIndicator(key: Key('loading_indicator')));
          } else if (state is ArticleLoaded) {
            return RefreshIndicator(
              key: Key('refresh_indicator'),
              onRefresh: () async {
                BlocProvider.of<ArticleBloc>(context).add(FetchArticles());
              },
              child: ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  return ArticleItem(state.articles[index], key: Key('article_item_$index'));
                },
              ),
            );
          } else if (state is ArticleError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Error: ${state.message}', key: Key('error_message'))),
                ElevatedButton(
                  key: Key('retry_button'),
                  onPressed: () {
                    BlocProvider.of<ArticleBloc>(context).add(FetchArticles());
                  },
                  child: Text('Reintentar'),
                ),
                FutureBuilder<List<Article>>(
                  future: BlocProvider.of<ArticleBloc>(context).getArticlesFromDb(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(key: Key('db_loading_indicator')));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error cargando desde DB: ${snapshot.error}', key: Key('db_error_message')));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No hay artículos guardados', key: Key('no_saved_articles')));
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ArticleItem(snapshot.data![index], key: Key('saved_article_item_$index'));
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          } else {
            return Container(
              child: Center(child: Text('Ocurrio un error inesperado', key: Key('unknown_error_message'))),
            );
          }
        },
      ),
    );
  }
}

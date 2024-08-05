import 'package:flutter/material.dart';
import 'package:test_skuad/models/article_model.dart';

class ArticleItem extends StatelessWidget {
  final Article article;

  ArticleItem(this.article, {required Key key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title),
      subtitle: Text('by: ${article.author}'),
      trailing: Text('${article.createdAt.toLocal()}'),
    );
  }
}

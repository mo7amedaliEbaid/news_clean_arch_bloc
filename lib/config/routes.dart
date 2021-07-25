import 'package:flutter/material.dart';
import '../features/articles/domain/entities/article.dart';
import '../features/articles/presentation/pages/article_details/article_details.dart';
import '../features/articles/presentation/pages/bookmarked_article/bookmarked_article.dart';
import '../features/articles/presentation/pages/home/news.dart';


sealed class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const NewsPage());

      case '/ArticleDetails':
        return _materialRoute(ArticleDetailsPage(article: settings.arguments as ArticleEntity));

      case '/Bookmarks':
        return _materialRoute(const Bookmarks());
        
      default:
        return _materialRoute(const NewsPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

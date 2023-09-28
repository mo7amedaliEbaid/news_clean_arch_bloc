import 'package:flutter/material.dart';
import '../features/daily_news/domain/entities/article.dart';
import '../features/daily_news/presentation/pages/article_details/article_details.dart';
import '../features/daily_news/presentation/pages/bookmarked_article/bookmarked_article.dart';
import '../features/daily_news/presentation/pages/home/news.dart';


class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const NewsPage());

      case '/ArticleDetails':
        return _materialRoute(ArticleDetailsView(article: settings.arguments as ArticleEntity));

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

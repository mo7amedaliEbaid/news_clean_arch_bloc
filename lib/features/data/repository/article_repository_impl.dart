
import 'package:news_clean_arch_bloc/core/resources/data_state.dart';
import 'package:news_clean_arch_bloc/features/data/models/article.dart';
import 'package:news_clean_arch_bloc/features/domain/entities/article.dart';
import 'package:news_clean_arch_bloc/features/domain/repository/article_repository.dart';

class ArticleRepoImpl implements ArticleRepository{
  @override
  Future<DataState<List<ArticleModel>>> getArticles() {
    // TODO: implement getArticles
    throw UnimplementedError();
  }

}
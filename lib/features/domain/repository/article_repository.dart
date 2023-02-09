import 'package:news_clean_arch_bloc/features/domain/entities/article.dart';

import '../../../core/resources/data_state.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getArticles();
}

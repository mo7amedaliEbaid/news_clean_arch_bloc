
import 'package:news_clean_arch_bloc/core/resources/data_state.dart';
import 'package:news_clean_arch_bloc/core/usecases/usecase.dart';
import 'package:news_clean_arch_bloc/features/domain/entities/article.dart';
import 'package:news_clean_arch_bloc/features/domain/repository/article_repository.dart';

interface class GetArticleUseCase implements UseCase<DataState<List<ArticleEntity>>,void>{

 final ArticleRepository _articleRepository;

 GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void parameters}) {

    return _articleRepository.getArticles();

  }
  
}
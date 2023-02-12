

import '../../../../core/usecase/usecase.dart';
import '../entities/article.dart';
import '../repository/article_repository.dart';

interface class RemoveArticleUseCase implements UseCase<void,ArticleEntity>{
  
  final ArticleRepository _articleRepository;

  RemoveArticleUseCase(this._articleRepository);
  
  @override
  Future<void> call({ArticleEntity ? paramaters}) {
    return _articleRepository.removeArticle(paramaters!);
  }
  
}
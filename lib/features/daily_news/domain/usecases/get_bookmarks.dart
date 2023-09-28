

import '../../../../core/usecase/usecase.dart';
import '../entities/article.dart';
import '../repository/article_repository.dart';



interface class GetBookmarks implements UseCase<List<ArticleEntity>,void>{
  
  final ArticleRepository _articleRepository;

  GetBookmarks(this._articleRepository);
  
  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getBookmarks();
  }
  
}
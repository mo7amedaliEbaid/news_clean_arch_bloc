
part of 'local_article_bloc.dart';

@immutable
abstract class LocalArticleEvent extends Equatable {
  final ArticleEntity ? article;

  const LocalArticleEvent({this.article});

  @override
  List<Object> get props => [article!];
}

interface class GetSavedArticlesEvent extends LocalArticleEvent {
  const GetSavedArticlesEvent();
}

interface class RemoveArticleEvent extends LocalArticleEvent {
  const RemoveArticleEvent(ArticleEntity article) : super(article: article);
}

interface class SaveArticleEvent extends LocalArticleEvent {
  const SaveArticleEvent(ArticleEntity article) : super(article: article);
}

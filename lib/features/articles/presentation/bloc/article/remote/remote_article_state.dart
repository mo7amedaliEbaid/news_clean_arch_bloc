part of 'remote_article_bloc.dart';

@immutable
abstract class RemoteArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioError? error;
  
  const RemoteArticleState({this.articles,this.error});
  
  @override
  List<Object> get props => [articles!, error!];
}

interface class RemoteArticleLoading extends RemoteArticleState {
  const RemoteArticleLoading();
}

interface class RemoteArticleLoaded extends RemoteArticleState {
  const RemoteArticleLoaded(List<ArticleEntity> article) : super(articles: article);
}

interface class RemoteArticleError extends RemoteArticleState {
  const RemoteArticleError(DioError error) : super(error: error);
}
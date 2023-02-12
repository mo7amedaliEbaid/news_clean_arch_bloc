
part of 'local_article_bloc.dart';

@immutable
abstract class LocalArticleState extends Equatable {
  final List<ArticleEntity> ? articles;

  const LocalArticleState({this.articles});

  @override
  List<Object> get props => [articles!];
}

interface class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

interface class LocalArticleLoaded extends LocalArticleState {
  const LocalArticleLoaded(List<ArticleEntity> articles) : super(articles: articles);
}
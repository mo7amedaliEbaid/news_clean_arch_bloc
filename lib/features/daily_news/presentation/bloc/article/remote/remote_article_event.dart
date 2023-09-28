part of 'remote_article_bloc.dart';

@immutable
abstract class RemoteArticleEvent {
  const RemoteArticleEvent();
}

interface class GetArticleEvent extends RemoteArticleEvent {
  const GetArticleEvent();
}
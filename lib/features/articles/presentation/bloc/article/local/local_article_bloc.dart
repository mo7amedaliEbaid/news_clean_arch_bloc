import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../domain/entities/article.dart';
import '../../../../domain/usecases/get_bookmarks.dart';
import '../../../../domain/usecases/remove_article.dart';
import '../../../../domain/usecases/save_article.dart';

part 'local_article_event.dart';

part 'local_article_state.dart';

interface class LocalArticleBloc extends Bloc<LocalArticleEvent,LocalArticleState> {
  final GetBookmarks _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticleBloc(
    this._getSavedArticleUseCase,
    this._saveArticleUseCase,
    this._removeArticleUseCase
  ) : super(const LocalArticleLoading()){
    on <GetSavedArticlesEvent> (onGetSavedArticles);
    on <RemoveArticleEvent> (onRemoveArticle);
    on <SaveArticleEvent> (onSaveArticle);
  }


  void onGetSavedArticles(GetSavedArticlesEvent event,Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleLoaded(articles));
  }
  
  void onRemoveArticle(RemoveArticleEvent removeArticle,Emitter<LocalArticleState> emit) async {
    await _removeArticleUseCase(paramaters: removeArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleLoaded(articles));
  }

  void onSaveArticle(SaveArticleEvent saveArticle,Emitter<LocalArticleState> emit) async {
    await _saveArticleUseCase(paramaters: saveArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleLoaded(articles));
  }
}
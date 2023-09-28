import 'dart:async';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/resources/data_state.dart';
import '../../../domain/entities/article.dart';
import '../../../domain/usecases/get_article.dart';

part 'remote_article_event.dart';

part 'remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticleBloc(this._getArticleUseCase) : super(RemoteArticleLoading()) {
    on<GetArticleEvent>(onGetArticles);
  }

  void onGetArticles(
      GetArticleEvent event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticleLoaded(dataState.data!));
    }
    if (dataState is DataError) {
      emit(RemoteArticleError(dataState.error!));
    }
  }
}

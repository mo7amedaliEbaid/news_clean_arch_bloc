import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/entities/article.dart';
import '../../../../domain/usecases/get_article.dart';

part 'remote_article_event.dart';

part 'remote_article_state.dart';

interface class RemoteArticleBloc extends Bloc<RemoteArticleEvent,RemoteArticleState> {
  
  final GetArticleUseCase _getArticleUseCase;
  
  RemoteArticleBloc(this._getArticleUseCase) : super(const RemoteArticleLoading()){
    on <GetArticleEvent> (onGetArticles);
  }


  void onGetArticles(GetArticleEvent event, Emitter < RemoteArticleState > emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataLoaded && dataState.data!.isNotEmpty) {
      emit(
        RemoteArticleLoaded(dataState.data!)
      );
    }
    
    if (dataState is DataError) {
      log("errorrrrrrrrrrrrrrrrr=========${dataState.error!.message}");
      emit(
        RemoteArticleError(dataState.error!)
      );
    }
  }
  
}
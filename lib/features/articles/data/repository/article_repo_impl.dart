import 'dart:io';

import 'package:dio/dio.dart';


import '../../../../core/consts/consts.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entities/article.dart';
import '../../domain/repository/article_repository.dart';
import '../data_sources/local/app_database.dart';
import '../data_sources/remote/news_api_service.dart';
import '../models/article.dart';

interface class ArticleRepoImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  ArticleRepoImpl(this._newsApiService,this._appDatabase);
  
  @override
  Future<DataState<List<ArticleModel>>> getArticles() async {
   try {
    final httpResponse = await _newsApiService.getArticles(
      apiKey:APIKEY,
      country:COUNTRY,
      category:CATEGORY,
    );

    if (httpResponse.response.statusCode == HttpStatus.ok) {
      return DataLoaded(httpResponse.data);
    } else {
      return DataError(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioErrorType.response,
          requestOptions: httpResponse.response.requestOptions
        )
      );
    }
   } on DioError catch(e){
    return DataError(e);
   }
  }

  @override
  Future<List<ArticleModel>> getBookmarks() async {
    return _appDatabase.articleDAO.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDAO.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDAO.insertArticle(ArticleModel.fromEntity(article));
  }
  
}
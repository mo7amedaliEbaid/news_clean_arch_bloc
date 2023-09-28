import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:news_clean_arch_bloc/core/consts/api_consts.dart';
import 'package:news_clean_arch_bloc/core/resources/data_state.dart';
import 'package:news_clean_arch_bloc/features/data/data_sources/remote/news_api_service.dart';
import 'package:news_clean_arch_bloc/features/data/models/article.dart';
import 'package:news_clean_arch_bloc/features/domain/entities/article.dart';
import 'package:news_clean_arch_bloc/features/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

interface class ArticleRepoImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepoImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getArticles() async {
    try {
      final httpResponse = await _newsApiService.getArticles(
        apiKey: APIKEY,
        country: COUNTRY,
        category: CATEGORY,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataError(
          DioError(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioErrorType.response,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioError catch (e) {
      return DataError(e);
    }
  }
}

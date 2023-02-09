import 'package:news_clean_arch_bloc/core/consts/api_consts.dart';
import 'package:news_clean_arch_bloc/features/data/models/article.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl: BASEURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET("/top-headlines")
  Future<HttpResponse<List<ArticleModel>>> getArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
}


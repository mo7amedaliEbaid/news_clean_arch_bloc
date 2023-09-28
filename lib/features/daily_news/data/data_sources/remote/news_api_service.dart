import 'package:retrofit/retrofit.dart';
import '../../../../../core/consts/consts.dart';
import 'package:dio/dio.dart';

import '../../models/article.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl:BASEURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;
  
  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getArticles({
    @Query("apiKey") String ? apiKey,
    @Query("country") String ? country,
    @Query("category") String ? category,
  });
}
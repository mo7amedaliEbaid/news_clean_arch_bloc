import 'package:get_it/get_it.dart';
import 'package:news_clean_arch_bloc/features/data/data_sources/remote/news_api_service.dart';
import 'package:dio/dio.dart';
import 'package:news_clean_arch_bloc/features/data/repository/article_repository_impl.dart';
import 'package:news_clean_arch_bloc/features/domain/usecases/get_article.dart';
import 'package:news_clean_arch_bloc/features/presentation/bloc/remote/remote_article_bloc.dart';

final s1 = GetIt.instance;

Future<void> initializeDependencies() async {
  s1.registerSingleton<Dio>(Dio());

  s1.registerSingleton<NewsApiService>(NewsApiService(s1()));

  s1.registerSingleton<ArticleRepoImpl>(ArticleRepoImpl(s1()));

  s1.registerSingleton<GetArticleUseCase>(GetArticleUseCase(s1()));

  s1.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(s1()));
}

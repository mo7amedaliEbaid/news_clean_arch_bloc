import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'features/articles/data/data_sources/local/app_database.dart';
import 'features/articles/data/data_sources/remote/news_api_service.dart';
import 'features/articles/data/repository/article_repo_impl.dart';
import 'features/articles/domain/repository/article_repository.dart';
import 'features/articles/domain/usecases/get_article.dart';
import 'features/articles/domain/usecases/get_bookmarks.dart';
import 'features/articles/domain/usecases/remove_article.dart';
import 'features/articles/domain/usecases/save_article.dart';
import 'features/articles/presentation/bloc/article/local/local_article_bloc.dart';
import 'features/articles/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
  
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(
    ArticleRepoImpl(sl(),sl())
  );
  
  //UseCases
  sl.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(sl())
  );

  sl.registerSingleton<GetBookmarks>(
    GetBookmarks(sl())
  );

  sl.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(sl())
  );
  
  sl.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(sl())
  );


  //Blocs
  sl.registerFactory<RemoteArticleBloc>(
    ()=> RemoteArticleBloc(sl())
  );

  sl.registerFactory<LocalArticleBloc>(
    ()=> LocalArticleBloc(sl(),sl(),sl())
  );


}
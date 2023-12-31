import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_clean_arch_bloc/config/app_theme.dart'as theme;

import 'config/routes.dart';
import 'features/articles/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'features/articles/presentation/pages/home/news.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider<RemoteArticleBloc>(
      create: (context) => sl()..add(const GetArticleEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.themeLight,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const NewsPage()
      ),
    );
  }
}


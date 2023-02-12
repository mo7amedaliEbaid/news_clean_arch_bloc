import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_clean_arch_bloc/config/configs.dart';


import '../../../../../config/app.dart';
import '../../../domain/entities/article.dart';
import '../../bloc/article/remote/remote_article_bloc.dart';
import '../../widgets/article_tile.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody() ,
    );
  }
  
  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
          'Hot Articles',
        ),
        actions: [
          GestureDetector(
            onTap: () => _onShowBookmarksViewTapped(context),
            child:  Padding(
              padding: Space.h1!,
              child: Icon(Icons.bookmark),
            ),
          ),
        ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc,RemoteArticleState> (
      builder: (_,state) {
        if (state is RemoteArticleLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteArticleError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteArticleLoaded) {
          return ListView.builder(
           itemBuilder: (context,index){
            return ArticleWidget(
              article: state.articles![index] ,
              onArticlePressed: (article) => _onArticlePressed(context,article),
            );
           },
           itemCount: state.articles!.length,
         );
        }
        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  void _onShowBookmarksViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/Bookmarks');
  }
  
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_clean_arch_bloc/config/configs.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/article.dart';
import '../../bloc/article/local/local_article_bloc.dart';

class ArticleDetailsPage extends HookWidget {
  final ArticleEntity? article;

  const ArticleDetailsPage({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text("Article Details"),
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: Padding(
            padding: Space.h1!,
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Space.top!,
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: Space.h1!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(article!.title!, style: AppText.h3b),

          Space.y!,
          // DateTime
          Row(
            children: [
               Icon(Icons.punch_clock,color: Colors.blue, size: AppDimensions.normalize(7)),
              Space.x!,
              Text(
                SuperString(article!.publishedAt!).date,
                style: AppText.l1b,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.maxFinite,
      height: AppDimensions.normalize(90),
      margin: Space.v,
      child: Image.network(article!.urlToImage!, fit: BoxFit.cover),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: Space.all(.8),
      child: Text(
        '${article!.description ?? ''}\n\n${article!.content ?? ''}',
        style: AppText.b1,
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: const Icon(Icons.bookmark),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticleEvent(article!));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Article saved successfully.'),
      ),
    );
  }
}

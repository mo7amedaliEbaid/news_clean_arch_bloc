import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_clean_arch_bloc/config/configs.dart';
import '../../domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? article;
  final bool? isRemovable;
  final void Function(ArticleEntity article)? onRemove;
  final void Function(ArticleEntity article)? onArticlePressed;

  const ArticleWidget({
    Key? key,
    this.article,
    this.onArticlePressed,
    this.isRemovable = false,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        padding: Space.all(),
        height: AppDimensions.normalize(70),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            Space.x!,
            _buildTitleAndDescription(),
            _buildRemovableArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: article!.urlToImage!,
        imageBuilder: (context, imageProvider) => ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.normalize(7)),
              child: Container(
                width: AppDimensions.normalize(55),
                height: double.maxFinite,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              ),
            ),
        progressIndicatorBuilder: (context, url, downloadProgress) => ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.normalize(12)),
              child: Container(
                width: AppDimensions.normalize(55),
                height: double.maxFinite,
                child: CupertinoActivityIndicator(),
                decoration: BoxDecoration(),
              ),
            ),
        errorWidget: (context, url, error) => Padding(
              padding: Space.all(),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppDimensions.normalize(12)),
                child: Container(
                  width: AppDimensions.normalize(55),
                  height: double.maxFinite,
                  child: Icon(Icons.error),
                ),
              ),
            ));
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: Space.vf(.4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              article!.title ?? '',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: AppText.h3b,
            ),

            // Description
            Expanded(
              child: Padding(
                padding: Space.vf(.2),
                child: Text(
                  article!.description ?? '',
                  maxLines: 2,
                  style: AppText.b2,
                ),
              ),
            ),

            // Datetime
            Row(
              children: [
                Icon(
                  Icons.timeline_outlined,
                  color: Colors.blue,
                  size: AppDimensions.normalize(10),
                ),
                Space.xf(.5),
                Text(
                  SuperString(article!.publishedAt!).date,
                  style: AppText.l1b,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemovableArea() {
    if (isRemovable!) {
      return GestureDetector(
        onTap: _onRemove,
        child:  Padding(
          padding: Space.v!,
          child: Icon(Icons.remove_circle_outline, color: Colors.red),
        ),
      );
    }
    return Container();
  }

  void _onTap() {
    if (onArticlePressed != null) {
      onArticlePressed!(article!);
    }
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove!(article!);
    }
  }
}

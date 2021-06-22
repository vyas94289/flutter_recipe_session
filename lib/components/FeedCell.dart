import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipe_session/components/iconWithText.dart';
import 'package:flutter_recipe_session/utils/Styles.dart';
import 'package:flutter_recipe_session/models/RecipeInfo.dart';
import 'package:flutter_recipe_session/utils/Const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FeedCell extends StatelessWidget {
 
  final RecipeList feed;
  final Function onSelected;

  const FeedCell({Key key, this.feed, this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            buildCachedNetworkImage(),
            gradientLayer(),
            rippleView(),
            buildInfoContent(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                favoriteButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget favoriteButton() => IconButton(
        icon: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        onPressed: () {
          print("object");
        },
      );

  Widget rippleView() => Material(
      color: Colors.transparent, child: InkWell(onTap: this.onSelected));

  Widget gradientLayer() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Colors.transparent,
        
          Colors.black.withAlpha(200)
        ],
      )));

  Widget buildCachedNetworkImage() => feed.photo == null ? Container() : CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          )),
        ),
        imageUrl: feed.photo ?? "",
        placeholder: (context, url) => FlutterLogo(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );

  Widget buildInfoContent() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Spacer(),
            Text(
              feed.name ?? "",
              style: Styles.titleBold(),
            ),
            SizedBox(
              height: 2,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothStarRating(
                    allowHalfRating: true,
                    starCount: 5,
                    size: 16,
                    isReadOnly: true,
                    rating: Const.random(5).toDouble(),
                    borderColor: Colors.white,
                    color: Colors.white,
                  ),
                  VerticalDivider(color: Colors.white),
                  TextWithIcon(
                    icon: Icons.access_time,
                    text: feed.preparationTime,
                  ),
                  VerticalDivider(color: Colors.white),
                  (feed.complexity ?? Complexity.easy).complexityView(null),
                  VerticalDivider(color: Colors.white),
                  TextWithIcon(
                    icon: Icons.restaurant,
                    text: feed.serves ?? "",
                  )
                ],
              ),
            ),
          ],
        ),
      );
}

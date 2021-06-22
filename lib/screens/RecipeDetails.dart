import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipe_session/models/RecipeInfo.dart';
import 'package:flutter_recipe_session/utils/Colors.dart';
import 'package:flutter_recipe_session/utils/Const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RecipeDetails extends StatefulWidget {
  final RecipeList recipeDetails;
  RecipeDetails({Key key, this.recipeDetails}) : super(key: key);

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState(recipeDetails);
}

class _RecipeDetailsState extends State<RecipeDetails> {
  double topPadding;
  final RecipeList recipeDetails;
  _RecipeDetailsState(this.recipeDetails);

  @override
  Widget build(BuildContext context) {
    final double headerHeight = 250.0;
    topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: headerHeight,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipeDetails.name,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              background: _backLayer(),
            ),
          ),
          SliverToBoxAdapter(child: Expanded(child: _mainContenScroll())),
        ],
      ),
    );
  }

  Widget _backLayer() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                )),
              ),
              imageUrl: recipeDetails.photo ?? "",
              placeholder: (context, url) => FlutterLogo(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          gradientLayer()
        ],
      ),
    );
  }

  Widget gradientLayer() => Expanded(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
            AppColors.background
          ],
        ))),
      );

  Widget _mainContenScroll() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          addRepaintBoundaries: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) =>
              _buildSection(index),
          itemCount: 3,
        ),
      ),
    );
  }

  Widget _buildSection(int index) {
    String title;
    if (index == 0)
      title = 'Details';
    else if (index == 1)
      title = 'Ingredients';
    else
      title = 'Directions';
    return ExpansionTile(
      title: Text(title),
      children: _buildSectionChildren(index),
    );
  }

  List<Widget> _buildSectionChildren(int index) {
    List<Widget> list = [];
    if (index == 0) {
      var intList = new List<int>.generate(5, (i) => i);
      list = intList.map((e) => _buildDetailsSectionForIndex(e)).toList();
    } else if (index == 1) {
      list = [_buildIngredientSection()];
    } else {
      List<String> titles = [
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        "In maximus odio lacus, sed fringilla purus molestie vitae.",
        "Praesent ac lectus condimentum, mattis mauris congue, volutpat dolor.",
        "Duis in augue porttitor, finibus est at, pretium augue",
        "Donec in urna vel magna pulvinar venenatis.",
        "Nulla luctus commodo tellus id pharetra. Nunc malesuada tortor quam, et dictum enim aliquet vel.",
        "Praesent a metus egestas, fermentum magna vel, suscipit est. Nulla vel fringilla augue."
      ];
      list = titles.map((e) => _buildStepTile(e)).toList();
    }
    return list;
  }

  Widget _buildDetailsSectionForIndex(int index) {
    switch (index) {
      case 0:
        return _buildDetailsSection(Icons.person, "Publisher", recipeDetails.fullName);
      case 1:
        return ListTile(
          minLeadingWidth: 4,
          leading: Container(
            height: double.infinity,
            child: Icon(Icons.tune),
          ),
          title: Text("Complexity"),
          subtitle: recipeDetails.complexity.complexityView(Colors.grey),
        );
      case 2:
        return _buildDetailsSection(
            Icons.schedule, "Preparation Time", recipeDetails.preparationTime ?? "");
      case 3:
        return _buildDetailsSection(
            Icons.videocam, "Youtube Link", recipeDetails.ytUrl ?? "www.youtube.com");
      default:
        return ListTile(
          minLeadingWidth: 4,
          leading: Container(
            height: double.infinity,
            child: Icon(Icons.star),
          ),
          title: Text("Rating"),
          subtitle: SmoothStarRating(
            allowHalfRating: true,
            starCount: 5,
            size: 16,
            isReadOnly: true,
            rating: Const.random(5).toDouble(),
            borderColor: Colors.grey,
            color: Colors.grey,
          ),
        );
    }
  }

  Widget _buildDetailsSection(IconData icon, String title, String subTitle) {
    return ListTile(
      minLeadingWidth: 4,
      leading: Container(
        height: double.infinity,
        child: Icon(icon),
      ),
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }

  Widget _buildStepTile(String title) => ListTile(
        minLeadingWidth: 4,
        leading: Container(
          width: 8.0,
          height: 8.0,
          decoration: new BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(title),
      );

  Widget _buildIngredientSection() {
    List<String> assetsList = [
      AssetsIcons.blueberry,
      AssetsIcons.butter,
      AssetsIcons.flour,
      AssetsIcons.strawberry,
      AssetsIcons.water,
      AssetsIcons.eggs,
    ];
    return Container(
      height: 70,
      margin: EdgeInsets.symmetric(horizontal: 14),
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: assetsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: Card(
                    child: Image.asset(
                  assetsList[index],
                )),
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_recipe_session/components/FeedCell.dart';
import 'package:flutter_recipe_session/components/SearchTextField.dart';
import 'package:flutter_recipe_session/components/commonComponents.dart';
import 'package:flutter_recipe_session/main.dart';
import 'package:flutter_recipe_session/models/RecipeInfo.dart';
import 'package:flutter_recipe_session/network/api.dart';
import 'package:flutter_recipe_session/screens/FilterScreen.dart';
import 'package:flutter_recipe_session/screens/RecipeDetails.dart';
import 'package:flutter_recipe_session/utils/Colors.dart';
import 'package:flutter_recipe_session/utils/VisibilityState.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RecipeList> feeds = [];
  String errorMessage = "";
  VisibilityState visibilityState = VisibilityState.idle;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    fetchFeeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text('Home'),
          actions: [logoutButton(context)],
        ),
        body: Container(
          color: AppColors.primary,
          child: mainContent(context),
        ),
      );

  Widget mainContent(BuildContext context) {
    switch (visibilityState) {
      case VisibilityState.idle:
        return noDataView("Search Somthing");
      case VisibilityState.loading:
        return loadingView();
      case VisibilityState.loaded:
        return buildContent(context);
      case VisibilityState.error:
        return noDataView(errorMessage);
    }
    return null;
  }

  Widget buildContent(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: SearchTextField(
                      iconData: Icons.search,
                      hintText: "Search ...",
                      controller: this.controller,
                    ),
                  ),
                  SizedBox(width: 8),
                  buildFilterButton(context)
                ],
              ),
            ),
          ),
          Expanded(child: buildListView(context))
        ],
      );

  AspectRatio buildFilterButton(BuildContext context) => AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Material(
          color: AppColors.fillColor,
          child: InkWell(
            child: Icon(
              Icons.tune,
              color: Colors.white,
            ),
            onTap: () {
              _navigateAndDisplaySelection(context);
            },
          ),
        ),
      ));

  ListView buildListView(BuildContext buildContext) {
    return ListView.builder(
        itemCount: feeds.length,
        itemBuilder: (context, index) {
          return FeedCell(
            feed: feeds[index],
            onSelected: () {
              _navigateRecipeDetails(buildContext, feeds[index]);
            },
          );
        });
  }

  Widget logoutButton(BuildContext context) => IconButton(
        icon: Icon(
          Icons.logout,
          color: Colors.white,
        ),
        onPressed: () {
          appAuth.logout().then(
              (_) => Navigator.of(context).pushReplacementNamed('/login'));
        },
      );

  fetchFeeds() {
    setState(() {
      visibilityState = VisibilityState.loading;
    });
    ApiRequest.shared.fetchFeeds().then((value) {
      this.feeds = value;
      errorMessage = value.isEmpty ? "No Data" : "";
      setState(() {
        if (errorMessage.isEmpty) {
          visibilityState = VisibilityState.loaded;
        } else {
          visibilityState = VisibilityState.error;
        }
      });
    }).catchError((err) {
      errorMessage = err;
      visibilityState = VisibilityState.error;
    });
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FilterScreen()),
    );
  }

  void _navigateRecipeDetails(BuildContext context, RecipeList recipeList) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RecipeDetails(
                recipeDetails: recipeList,
              )),
    );
  }
}

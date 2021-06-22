import 'package:flutter/material.dart';
import 'package:flutter_recipe_session/components/GridSelectionView.dart';
import 'package:flutter_recipe_session/utils/Colors.dart';
import 'package:flutter_recipe_session/utils/Const.dart';
import 'package:flutter_recipe_session/utils/Styles.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

enum GridType { meals, course }

class _FilterScreenState extends State<FilterScreen> {
  List<String> meals = ["Breakfast", "Brunch", "Lunch", "Dinner"];
  List<String> course = [
    "Soup",
    "Appetizer",
    "Starter",
    "Main Dish",
    "Side",
    "Dessert",
    "Drinks"
  ];
  List<String> headers = [
    "Meals",
    "Course",
    "Complexity",
    "Serving",
    "Preparation Time",
    "Rating"
  ];

  double gridChildRatio = 0;
  String selectedMeal;
  String selectedCourse;
  String selectedComplexity;
  RangeValues _currentServeRangeValues = const RangeValues(4, 10);
  RangeValues _currentTimeRangeValues = const RangeValues(30, 60);

  @override
  Widget build(BuildContext context) {
    gridChildRatio = MediaQuery.of(context).size.width / 120;
    selectedMeal = meals[0];
    selectedCourse = course[0];
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Filter'),
        actions: [saveButton(context)],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.formBackground,
        child: mainContent(),
      ),
    );
  }

  Widget mainContent() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowList(),
          ),
        ),
      );

  List<Widget> rowList() {
    List<Widget> widgetList = [];
    for (int index = 0; index < 6; index++) {
      widgetList.add(header(headers[index]));
      widgetList.add(spacer());
      widgetList.add(getColumWidgetForIndex(index));
      widgetList.add(spacer());
      if (index < 5) {
        widgetList.add(Divider(color: Colors.grey));
        widgetList.add(spacer());
      }
    }
    return widgetList;
  }

  Widget getColumWidgetForIndex(int index) {
    switch (index) {
      case 0:
        return GridSelectionView(
          gridChildRatio: gridChildRatio,
          itemArray: meals,
          selectedItem: meals[0],
          onSelection: (e) => onMealSelection(e),
        );
      case 1:
        return GridSelectionView(
          gridChildRatio: gridChildRatio,
          itemArray: course,
          selectedItem: course[0],
          onSelection: (e) => onMeCourseSelection(e),
        );
      case 2:
        return GridSelectionView(
          gridChildRatio: gridChildRatio,
          itemArray: Const.allComplexityTitleArray,
          selectedItem: Const.allComplexityTitleArray[1],
          onSelection: (e) => onComplexitySelection(e),
        );
      case 3:
        return _buildServeSlider();
      case 4:
        return _buildPreparationTimeSlider();
      default:
        return _buildRatingView();
    }
  }

  Widget _buildServeSlider() => Row(
        children: [
          Text(_currentServeRangeValues.start.round().toString()),
          Expanded(
            child: RangeSlider(
              values: _currentServeRangeValues,
              min: 1,
              max: 20,
              divisions: 20,
              labels: RangeLabels(
                _currentServeRangeValues.start.round().toString(),
                _currentServeRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentServeRangeValues = values;
                });
              },
            ),
          ),
          Text(_currentServeRangeValues.end.round().toString()),
        ],
      );

  Widget _buildPreparationTimeSlider() => Row(
        children: [
          Text(Const.durationToString(_currentTimeRangeValues.start.round())),
          Expanded(
            child: RangeSlider(
              values: _currentTimeRangeValues,
              min: 5,
              max: 120,
              divisions: 115,
              labels: RangeLabels(
                Const.durationToString(_currentTimeRangeValues.start.round()),
                Const.durationToString(_currentTimeRangeValues.end.round()),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentTimeRangeValues = values;
                });
              },
            ),
          ),
          Text(Const.durationToString(_currentTimeRangeValues.end.round())),
        ],
      );

  Widget _buildRatingView() => SmoothStarRating(
        allowHalfRating: false,
        starCount: 5,
        size: 30,
        isReadOnly: false,
        rating: 1,
        borderColor: AppColors.primary,
        color: AppColors.primary,
        onRated: (rate) {
          print(rate.toString());
        },
      );

  Widget header(String string) {
    return Text(
      string,
      style: Styles.titleBold(),
    );
  }

  Widget spacer() {
    return SizedBox(
      height: 6,
    );
  }

  Widget saveButton(BuildContext context) => ElevatedButton(
      child: Text(
        'Save',
        style: Styles.subtitle(),
      ),
      onPressed: () {
        print('Pressed');
        //Navigator.pop(context, RecipeList());
      });

  onMealSelection(String title) {
    print(title);
    this.selectedMeal = title;
  }

  onMeCourseSelection(String title) {
    print(title);
    this.selectedCourse = title;
  }

  onComplexitySelection(String title) {
    print(title);
    this.selectedComplexity = title;
  }
}

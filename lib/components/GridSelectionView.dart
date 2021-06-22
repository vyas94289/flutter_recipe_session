import 'package:flutter/material.dart';
import 'package:flutter_recipe_session/screens/FilterScreen.dart';
import 'package:flutter_recipe_session/utils/Colors.dart';
import 'package:flutter_recipe_session/utils/Styles.dart';

class GridSelectionView extends StatefulWidget {
  @required
  final List<String> itemArray;
  @required
  final double gridChildRatio;
  @required
  final String selectedItem;
  @required
  final Function(String) onSelection;
  GridSelectionView(
      {Key key,
      this.itemArray,
      this.gridChildRatio,
      this.selectedItem,
      this.onSelection})
      : super(key: key);

  @override
  _GridSelectionViewState createState() => _GridSelectionViewState(
      itemArray, selectedItem, gridChildRatio, onSelection);
}

class _GridSelectionViewState extends State<GridSelectionView> {
  final List<String> itemArray;
  String selectedItem;
  final double gridChildRatio;
  final Function(String) onSelection;

  _GridSelectionViewState(
      this.itemArray, this.selectedItem, this.gridChildRatio, this.onSelection);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: gridChildRatio,
            children: itemArray.map((e) => _buildGridItem(e)).toList()));
  }

  Widget _buildGridItem(String title) {
    bool isSelected = selectedItem == title;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        children: [
          Container(
            color: AppColors.gridItem,
            child: Center(
                child: Text(
              title,
              style: Styles.subtitle(),
            )),
          ),
          if (isSelected)
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(70),
                border: Border.all(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
            ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  this.selectedItem = title;
                  this.onSelection(title);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

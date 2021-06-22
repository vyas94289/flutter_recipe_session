import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Const {
  static int random(int max) {
    return Random().nextInt(max) + 1;
  }

  static final List<String> allComplexityTitleArray = [
    "Easy",
    "Medium",
    "complex",
  ];

  static String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }
}

class AssetsImages {
  static final String imagePath = 'images/';
  static final String girl = imagePath + 'girl.jpg';
}

class AssetsIcons {
  static final String imagePath = 'images/';
  static final String blueberry = imagePath + 'Blueberry.png';
  static final String butter = imagePath + 'Butter.png';
  static final String eggs = imagePath + 'Eggs.png';
  static final String flour = imagePath + 'Flour.png';
  static final String strawberry = imagePath + 'Strawberry.png';
  static final String water = imagePath + 'Water.png';
}

class SvgIcons extends StatelessWidget {
  final String assetName;
  const SvgIcons({Key key, this.assetName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetName, semanticsLabel: assetName);
  }
}

enum Complexity {
  easy,
  medium,
  complex,
}

extension ComplexityExtension on Complexity {
  static Complexity getFromString(String string) {
    if (string == Const.allComplexityTitleArray[0]) {
      return Complexity.easy;
    } else if (string == Const.allComplexityTitleArray[1]) {
      return Complexity.medium;
    } else if (string == Const.allComplexityTitleArray[2]) {
      return Complexity.complex;
    } else {
      return null;
    }
  }

  String get title {
    switch (this) {
      case Complexity.easy:
        return "Easy";
      case Complexity.medium:
        return "Medium";
      case Complexity.complex:
        return "Complex";
    }
    return null;
  }

  bool get hasMedium {
    return this == Complexity.medium || this == Complexity.complex;
  }

  Widget complexityView(Color color) {
    return Row(
      children: [
        SizedBox(
          width: 34,
          height: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColoredRectangle(
                color: Colors.green,
              ),
              ColoredRectangle(
                color: this.hasMedium ? Colors.yellow : Colors.grey,
              ),
              ColoredRectangle(
                color: this == Complexity.complex ? Colors.red : Colors.grey,
              )
            ],
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          this.title,
          style: TextStyle(
            fontSize: 15,
            color: color ?? Colors.white,
          ),
        )
      ],
    );
  }
}

class ColoredRectangle extends StatelessWidget {
  final Color color;
  const ColoredRectangle({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      color: color,
    );
  }
}

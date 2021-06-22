import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipe_session/utils/Styles.dart';


class TextWithIcon extends StatelessWidget {

  final IconData icon;
  final String text;

 const TextWithIcon({Key key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                icon,
                size: 14,
                color: Colors.white,
              ),
            ),
            TextSpan(text: " " + text, style: Styles.subtitle()),
          ],
        ),
      ),
    );
  }
}

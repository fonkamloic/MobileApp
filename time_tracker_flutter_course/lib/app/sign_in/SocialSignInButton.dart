import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String text,
    Color color,
    Color textColor,
    @required String imagePath,
    VoidCallback onPressed,
  })  : assert(imagePath != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(imagePath),
              Text(
                text,
                style: TextStyle(color: textColor),
              ),
              Opacity(opacity: 0, child: Image.asset(imagePath)),
            ],
          ),
          color: color,
          onPressed: onPressed,
        );
}

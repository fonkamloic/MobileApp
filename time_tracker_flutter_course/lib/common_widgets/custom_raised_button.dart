import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final double height;

  CustomRaisedButton(
      {this.height: 40,
      this.child,
      this.onPressed,
      this.color,
      this.borderRadius: 2.0}): assert(borderRadius != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        elevation: 2.0,
        color: color,
        disabledColor: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        child: child,
      ),
    );
  }
}

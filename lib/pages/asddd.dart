import "package:flutter/material.dart";
void showMyDialog({
  @required Widget content,
  TextStyle contentTextStyle,
  List<Widget> actions,
  Color backgroundColor,
  double elevation,
  String semanticLabel,
  ShapeBorder shape,
  bool barrierDismissible = true,
  @required BuildContext context,
}) {
  assert(context != null);
  assert(content != null);
  showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return MyDailog(
        content: content,
        backgroundColor: backgroundColor,
        elevation: elevation,
        semanticLabel: semanticLabel,
        shape: shape,
        actions: actions,
      );
    },
  );
}

class MyDailog extends StatelessWidget {
  final Widget content;

  final List<Widget> actions;

  final Color backgroundColor;

  final double elevation;

  final String semanticLabel;

  final ShapeBorder shape;

  const MyDailog({
    Key key,
    this.content,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.semanticLabel,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: content,
      actions: actions,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
    );
  }
}
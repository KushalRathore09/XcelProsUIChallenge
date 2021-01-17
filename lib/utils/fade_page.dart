import 'package:flutter/widgets.dart';

class FadePage extends PageRouteBuilder {
  final Widget widget;

  FadePage({this.widget})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return widget;
          },
          transitionDuration: Duration(milliseconds: 700),
        );
}

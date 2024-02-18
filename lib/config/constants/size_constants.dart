import 'package:flutter/widgets.dart';

class SizeConstants {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double appBarHeight(BuildContext context) => 56.0;

  static double bottomNavigationBarHeight(BuildContext context) => 56.0;

  static double defaultPadding(BuildContext context) => 16.0;

  static double listItemHeight(BuildContext context) => 80.0;

  static double imageHeight(BuildContext context) =>
      screenHeight(context) * 0.4;

  static double replyFormHeight(BuildContext context) =>
      screenHeight(context) * 0.8;

  static double photoViewHeight(BuildContext context) =>
      screenHeight(context) * 0.4;

  static double photoViewWidth(BuildContext context) =>
      screenWidth(context);
}

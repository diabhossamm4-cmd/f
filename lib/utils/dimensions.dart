import 'package:flutter/material.dart';


class Dimensions {
  static double width;
  static double height;
  static Orientation orientation;

  /*static double deviceWidthInPixel(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double deviceHeightInPixel(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static Orientation deviceOrientation(BuildContext context) =>
      MediaQuery.of(context).orientation;*/

  static getWidth(double percent) {
    return width * (percent / 100);
  }

  static getHeight(double percent) {
    return height * (percent / 100);
  }

  static getDesirableWidth(double percent) {
    return orientation == Orientation.portrait
        ? width * (percent / 100)
        : getHeight(percent);
  }

  static getDesirableHeight(double percent) {
    return orientation == Orientation.portrait
        ? height * (percent / 100)
        : getWidth(percent);
  }
}

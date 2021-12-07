import 'package:flutter/material.dart';
import 'custom_color.dart';
import 'dimensions.dart';

class CustomStyle {
  static var textStyle = TextStyle(
      color: CustomColor.primaryColor,
      fontSize: Dimensions.defaultTextSize
  );

  static var hintTextStyle = TextStyle(
      color: Colors.grey,
      fontSize: Dimensions.defaultTextSize
  );

  static var listStyle = TextStyle(
    color: Colors.white,
    fontSize: Dimensions.defaultTextSize,
  );

  static var defaultStyle = TextStyle(
      color: Colors.white,
      fontSize: Dimensions.largeTextSize
  );

  static var focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
    borderSide: BorderSide(color: CustomColor.primaryColor.withOpacity(0.6)),
  );

  static var focusErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
    borderSide: BorderSide(color: CustomColor.accentColor.withOpacity(0.6)),
  );

}
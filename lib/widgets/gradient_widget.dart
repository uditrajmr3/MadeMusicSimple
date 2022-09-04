import 'package:flutter/material.dart';
import 'package:music_app/styles/colors.dart' as app_colors;

class CustomGradient {
  dynamic gradientCustom(int index) {
    var color;
    if (index == 0) {
      color = [
        app_colors.g2,
        app_colors.g3,
      ];
    } else if ((index % 2 == 0) && (index % 3 == 0) && (index % 5 == 0)) {
      color = [
        app_colors.r3,
        app_colors.r4,
      ];
    } else if ((index % 2 == 0) && (index % 3 == 0)) {
      color = [
        app_colors.b3,
        app_colors.b4,
      ];
    } else if ((index % 3 == 0) && (index % 5 == 0)) {
      color = [
        Colors.black,
        app_colors.g6,
      ];
    } else if (index % 2 == 0) {
      color = [
        app_colors.r5,
        app_colors.r6,
      ];
    } else if (index % 3 == 0) {
      color = [
        app_colors.g4,
        app_colors.g5,
      ];
    } else if (index % 5 == 0) {
      color = [
        app_colors.r1,
        app_colors.r2,
      ];
    } else if (index % 7 == 0) {
      color = [
        app_colors.b1,
        app_colors.b2,
      ];
    } else {
      color = [
        app_colors.r7,
        app_colors.b5,
      ];
    }
    return color;
  }
}

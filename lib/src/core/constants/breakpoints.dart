import 'package:flutter/material.dart';

/// Screen size breakpoints for responsive web design
abstract final class Breakpoints {
  static const double mobile = 640;
  static const double tablet = 1024;
  static const double desktop = 1280;
  static const double maxContentWidth = 1280;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobile;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobile && width < tablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tablet;
}

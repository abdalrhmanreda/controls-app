import 'package:flutter/material.dart';

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double minFontSize = fontSize * .8;
  double maxFontSize = fontSize * 1.2;
  double responsiveFontSize = fontSize * scaleFactor;
  return responsiveFontSize.clamp(minFontSize, maxFontSize);
}

double getScaleFactor(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 600) {
    return width / 400;
  } else if (width < 900) {
    return width / 700;
  } else {
    return width / 1000;
  }
}

// Helper extension for easy access
extension ResponsiveText on BuildContext {
  double responsiveFontSize(double fontSize) =>
      getResponsiveFontSize(this, fontSize: fontSize);
}

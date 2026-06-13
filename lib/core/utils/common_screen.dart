import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScaffoldScreen extends StatelessWidget {
  const ScaffoldScreen({
    super.key,
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.useGradient = true,
    this.gradientColors,
    this.gradientBegin = Alignment.topCenter,
    this.gradientEnd = Alignment.bottomCenter,
    this.gradientStops,
    this.backgroundImage,
    this.imageHeight,
  });

  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final bool useGradient;
  final List<Color>? gradientColors;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final List<double>? gradientStops;
  final String? backgroundImage;
  final double? imageHeight;

  @override
  Widget build(BuildContext context) {
    if (useGradient) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: gradientBegin,
            end: gradientEnd,
            colors:
                gradientColors ??
                [
                  const Color(0xFFB8D4E6), // Light blue
                  const Color(0xFFE8F4F8), // Very light blue
                  const Color(0xffe9f0f6), // White
                ],
            stops: gradientStops ?? [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Optional background image on top of gradient
            if (backgroundImage != null)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  backgroundImage!,
                  fit: BoxFit.cover,
                  height: imageHeight ?? 243.h,
                  width: double.infinity,
                ),
              ),
            // Scaffold content
            Scaffold(
              appBar: appBar,
              body: body,
              bottomNavigationBar: bottomNavigationBar,
              floatingActionButton: floatingActionButton,
              drawer: drawer,
              endDrawer: endDrawer,
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
      );
    } else {
      return Stack(
        children: [
          // Background layer with image at top and white below
          Column(
            children: [
              Expanded(
                child: Container(color: backgroundColor ?? Colors.white),
              ),
            ],
          ),
          // Content layer with transparent scaffold
          Scaffold(
            appBar: appBar,
            body: body,
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButton: floatingActionButton,
            drawer: drawer,
            endDrawer: endDrawer,
            backgroundColor: Colors.transparent,
          ),
        ],
      );
    }
  }
}

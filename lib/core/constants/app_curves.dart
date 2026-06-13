import 'package:flutter/animation.dart';

/// App curve constants for smooth animations
class AppCurves {
  // Private constructor to prevent instantiation
  AppCurves._();

  // Standard Curves
  static const Curve linear = Curves.linear;
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;

  // Emphasized Curves
  static const Curve emphasized = Curves.easeInOutCubic;
  static const Curve emphasizedAccelerate = Curves.easeInCubic;
  static const Curve emphasizedDecelerate = Curves.easeOutCubic;

  // Bounce Curves
  static const Curve bounceIn = Curves.bounceIn;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve bounceInOut = Curves.bounceInOut;

  // Elastic Curves
  static const Curve elasticIn = Curves.elasticIn;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve elasticInOut = Curves.elasticInOut;

  // Fast Out Slow In (Material Design)
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;

  // Decelerate
  static const Curve decelerate = Curves.decelerate;

  // Ease
  static const Curve ease = Curves.ease;

  // Custom Curves for Specific Animations
  static const Curve celebration = Curves.elasticOut;
  static const Curve levelUp = Curves.easeInOutBack;
  static const Curve badgeUnlock = Curves.bounceOut;
  static const Curve xpBarFill = Curves.easeInOut;
  static const Curve progressBar = Curves.easeOut;
  static const Curve cardFlip = Curves.easeInOutCubic;
  static const Curve pageTransition = Curves.easeInOutCubic;
  static const Curve dialogOpen = Curves.easeOutCubic;
  static const Curve dialogClose = Curves.easeInCubic;
  static const Curve streakFlame = Curves.easeInOutBack;
  static const Curve fadeTransition = Curves.easeInOut;
  static const Curve scaleTransition = Curves.easeOutBack;
  static const Curve slideTransition = Curves.easeOutCubic;

  // List Animations
  static const Curve listItemAppear = Curves.easeOutCubic;
  static const Curve listItemDisappear = Curves.easeInCubic;

  // Button Animations
  static const Curve buttonPress = Curves.easeIn;
  static const Curve buttonRelease = Curves.easeOut;

  // Achievement Animations
  static const Curve achievementPopup = Curves.elasticOut;
  static const Curve achievementGlow = Curves.easeInOut;

  // Milestone Animations
  static const Curve milestoneComplete = Curves.easeInOutBack;
  static const Curve checkmarkAppear = Curves.elasticOut;
}

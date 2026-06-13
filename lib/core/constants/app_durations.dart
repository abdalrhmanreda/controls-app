/// App duration constants for animations and transitions
class AppDurations {
  // Private constructor to prevent instantiation
  AppDurations._();

  // Short Durations
  static const Duration veryShort = Duration(milliseconds: 100);
  static const Duration short = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration long = Duration(milliseconds: 500);
  static const Duration veryLong = Duration(milliseconds: 800);

  // Animation Durations
  static const Duration fadeIn = Duration(milliseconds: 300);
  static const Duration fadeOut = Duration(milliseconds: 200);
  static const Duration slideIn = Duration(milliseconds: 400);
  static const Duration slideOut = Duration(milliseconds: 300);
  static const Duration scaleUp = Duration(milliseconds: 300);
  static const Duration scaleDown = Duration(milliseconds: 200);

  // Page Transitions
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration pageTransitionSlow = Duration(milliseconds: 500);

  // Progress Animations
  static const Duration progressBar = Duration(milliseconds: 800);
  static const Duration xpBarFill = Duration(milliseconds: 1000);
  static const Duration levelUpAnimation = Duration(milliseconds: 2000);

  // Celebration Animations
  static const Duration celebration = Duration(milliseconds: 3000);
  static const Duration badgeUnlock = Duration(milliseconds: 2000);
  static const Duration streakFlame = Duration(milliseconds: 1500);
  static const Duration confetti = Duration(milliseconds: 2500);

  // Dialog Animations
  static const Duration dialogOpen = Duration(milliseconds: 300);
  static const Duration dialogClose = Duration(milliseconds: 250);

  // Snackbar Duration
  static const Duration snackbarShort = Duration(milliseconds: 2000);
  static const Duration snackbarMedium = Duration(milliseconds: 3000);
  static const Duration snackbarLong = Duration(milliseconds: 4000);

  // Loading Indicators
  static const Duration loadingIndicator = Duration(milliseconds: 500);
  static const Duration shimmerEffect = Duration(milliseconds: 1500);

  // Splash Screen
  static const Duration splashScreen = Duration(milliseconds: 2000);
  static const Duration splashLogo = Duration(milliseconds: 1000);

  // Button Press
  static const Duration buttonPress = Duration(milliseconds: 150);
  static const Duration buttonRelease = Duration(milliseconds: 100);

  // Card Flip
  static const Duration cardFlip = Duration(milliseconds: 600);

  // Ripple Effect
  static const Duration ripple = Duration(milliseconds: 400);

  // Hover Effects
  static const Duration hover = Duration(milliseconds: 200);

  // Tooltip
  static const Duration tooltipShow = Duration(milliseconds: 300);
  static const Duration tooltipHide = Duration(milliseconds: 200);

  // Menu Animations
  static const Duration menuOpen = Duration(milliseconds: 300);
  static const Duration menuClose = Duration(milliseconds: 250);

  // List Item Animations
  static const Duration listItemAppear = Duration(milliseconds: 400);
  static const Duration listItemDisappear = Duration(milliseconds: 300);
  static const Duration staggerDelay = Duration(milliseconds: 50);

  // Tab Transitions
  static const Duration tabTransition = Duration(milliseconds: 300);

  // Milestone Completion
  static const Duration milestoneComplete = Duration(milliseconds: 1500);
  static const Duration checkmarkAppear = Duration(milliseconds: 500);

  // Achievement Unlock
  static const Duration achievementPopup = Duration(milliseconds: 2000);
  static const Duration achievementGlow = Duration(milliseconds: 1000);

  // Streak Counter
  static const Duration streakIncrement = Duration(milliseconds: 800);
  static const Duration streakPulse = Duration(milliseconds: 600);

  // Delay Durations
  static const Duration delayShort = Duration(milliseconds: 100);
  static const Duration delayMedium = Duration(milliseconds: 200);
  static const Duration delayLong = Duration(milliseconds: 500);

  // Debounce Durations
  static const Duration debounceShort = Duration(milliseconds: 300);
  static const Duration debounceMedium = Duration(milliseconds: 500);
  static const Duration debounceLong = Duration(milliseconds: 1000);

  // Auto-dismiss Durations
  static const Duration autoDismiss = Duration(seconds: 3);
  static const Duration autoDismissLong = Duration(seconds: 5);
}

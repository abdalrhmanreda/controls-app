/// Utility class for XP and level calculations
class XpCalculator {
  // Private constructor to prevent instantiation
  XpCalculator._();

  // XP required for each level (exponential growth)
  static int xpForLevel(int level) {
    return (100 * level * (1 + level * 0.5)).toInt();
  }

  // Calculate level from total XP
  static int calculateLevel(int totalXp) {
    int level = 1;
    int xpNeeded = 0;

    while (xpNeeded <= totalXp) {
      level++;
      xpNeeded += xpForLevel(level);
    }

    return level - 1;
  }

  // Calculate XP progress for current level
  static double calculateLevelProgress(int totalXp) {
    final currentLevel = calculateLevel(totalXp);
    final xpForNextLevel = xpForLevel(currentLevel + 1);

    // Calculate total XP needed up to current level
    int xpUpToCurrentLevel = 0;
    for (int i = 1; i <= currentLevel; i++) {
      xpUpToCurrentLevel += xpForLevel(i);
    }

    final xpInCurrentLevel = totalXp - xpUpToCurrentLevel;
    return xpInCurrentLevel / xpForNextLevel;
  }

  // Get remaining XP needed for next level
  static int xpRemainingForNextLevel(int totalXp) {
    final currentLevel = calculateLevel(totalXp);
    final xpForNextLevel = xpForLevel(currentLevel + 1);

    // Calculate total XP needed up to current level
    int xpUpToCurrentLevel = 0;
    for (int i = 1; i <= currentLevel; i++) {
      xpUpToCurrentLevel += xpForLevel(i);
    }

    final xpInCurrentLevel = totalXp - xpUpToCurrentLevel;
    return xpForNextLevel - xpInCurrentLevel;
  }

  // Calculate XP reward based on difficulty
  static int calculateXpReward({
    required String difficulty,
    bool isFirstTime = true,
    bool hasStreak = false,
  }) {
    int baseXp;

    switch (difficulty.toLowerCase()) {
      case 'easy':
        baseXp = 50;
        break;
      case 'medium':
        baseXp = 100;
        break;
      case 'hard':
        baseXp = 200;
        break;
      default:
        baseXp = 100;
    }

    // Bonus for first-time completion
    if (isFirstTime) {
      baseXp = (baseXp * 1.5).toInt();
    }

    // Bonus for having an active streak
    if (hasStreak) {
      baseXp = (baseXp * 1.2).toInt();
    }

    return baseXp;
  }

  // Get XP needed for a specific level
  static int totalXpForLevel(int level) {
    int totalXp = 0;
    for (int i = 1; i <= level; i++) {
      totalXp += xpForLevel(i);
    }
    return totalXp;
  }

  // Calculate bonus XP percentage
  static double calculateBonusMultiplier({
    bool hasStreak = false,
    int consecutiveDays = 0,
    bool isPremium = false,
  }) {
    double multiplier = 1.0;

    if (hasStreak && consecutiveDays > 0) {
      // 5% bonus per day, max 50% at 10 days
      multiplier += (consecutiveDays * 0.05).clamp(0.0, 0.5);
    }

    if (isPremium) {
      multiplier += 0.25; // 25% premium bonus
    }

    return multiplier;
  }
}

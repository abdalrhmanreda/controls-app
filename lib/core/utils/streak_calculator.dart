/// Utility class for streak calculations
class StreakCalculator {
  // Private constructor to prevent instantiation
  StreakCalculator._();

  // Calculate current streak from list of dates
  static int calculateStreak(List<DateTime> activityDates) {
    if (activityDates.isEmpty) return 0;

    // Sort dates in descending order
    final sortedDates = List<DateTime>.from(activityDates)
      ..sort((a, b) => b.compareTo(a));

    // Check if there's activity today or yesterday
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final latestDate = DateTime(
      sortedDates[0].year,
      sortedDates[0].month,
      sortedDates[0].day,
    );

    // Streak is broken if latest activity was before yesterday
    if (latestDate.isBefore(yesterday)) {
      return 0;
    }

    // Count consecutive days
    int streak = 1;
    DateTime currentDate = latestDate;

    for (int i = 1; i < sortedDates.length; i++) {
      final date = DateTime(
        sortedDates[i].year,
        sortedDates[i].month,
        sortedDates[i].day,
      );

      final expectedDate = currentDate.subtract(const Duration(days: 1));

      if (date == expectedDate) {
        streak++;
        currentDate = date;
      } else if (date == currentDate) {
        // Same day, skip
        continue;
      } else {
        // Gap found, break
        break;
      }
    }

    return streak;
  }

  // Check if streak is active (activity today or yesterday)
  static bool isStreakActive(List<DateTime> activityDates) {
    if (activityDates.isEmpty) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final latestDate = activityDates.reduce((a, b) => a.isAfter(b) ? a : b);
    final latestDateOnly = DateTime(
      latestDate.year,
      latestDate.month,
      latestDate.day,
    );

    return latestDateOnly == today || latestDateOnly == yesterday;
  }

  // Check if user completed activity today
  static bool hasActivityToday(List<DateTime> activityDates) {
    if (activityDates.isEmpty) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return activityDates.any((date) {
      final dateOnly = DateTime(date.year, date.month, date.day);
      return dateOnly == today;
    });
  }

  // Calculate longest streak ever
  static int calculateLongestStreak(List<DateTime> activityDates) {
    if (activityDates.isEmpty) return 0;

    // Sort dates
    final sortedDates = List<DateTime>.from(activityDates)
      ..sort((a, b) => a.compareTo(b));

    int longestStreak = 1;
    int currentStreak = 1;
    DateTime previousDate = DateTime(
      sortedDates[0].year,
      sortedDates[0].month,
      sortedDates[0].day,
    );

    for (int i = 1; i < sortedDates.length; i++) {
      final currentDate = DateTime(
        sortedDates[i].year,
        sortedDates[i].month,
        sortedDates[i].day,
      );

      if (currentDate == previousDate) {
        // Same day, skip
        continue;
      }

      final expectedDate = previousDate.add(const Duration(days: 1));

      if (currentDate == expectedDate) {
        currentStreak++;
        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
        }
      } else {
        currentStreak = 1;
      }

      previousDate = currentDate;
    }

    return longestStreak;
  }

  // Calculate streak bonus multiplier
  static double calculateStreakBonus(int streakDays) {
    if (streakDays == 0) return 1.0;

    // 5% bonus per day, max 50% bonus at 10 days
    return 1.0 + (streakDays * 0.05).clamp(0.0, 0.5);
  }

  // Get days until streak breaks
  static int daysUntilStreakBreaks(List<DateTime> activityDates) {
    if (!isStreakActive(activityDates)) return 0;

    if (hasActivityToday(activityDates)) {
      return 1; // Have until end of tomorrow
    } else {
      return 0; // Must complete today
    }
  }
}

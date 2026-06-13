/// Utility class for progress calculations
class ProgressCalculator {
  // Private constructor to prevent instantiation
  ProgressCalculator._();

  // Calculate overall progress percentage
  static double calculateProgress({
    required int completed,
    required int total,
  }) {
    if (total == 0) return 0.0;
    return (completed / total).clamp(0.0, 1.0);
  }

  // Calculate phase progress
  static double calculatePhaseProgress({
    required int completedMilestones,
    required int totalMilestones,
  }) {
    return calculateProgress(
      completed: completedMilestones,
      total: totalMilestones,
    );
  }

  // Calculate milestone progress
  static double calculateMilestoneProgress({
    required int completedCheckpoints,
    required int totalCheckpoints,
  }) {
    return calculateProgress(
      completed: completedCheckpoints,
      total: totalCheckpoints,
    );
  }

  // Format progress percentage
  static String formatProgressPercentage(double progress) {
    final percentage = (progress * 100).toInt();
    return '$percentage%';
  }

  // Get progress status
  static String getProgressStatus(double progress) {
    if (progress == 0.0) {
      return 'Not Started';
    } else if (progress < 1.0) {
      return 'In Progress';
    } else {
      return 'Completed';
    }
  }

  // Calculate time estimate based on progress
  static String estimateTimeRemaining({
    required double progress,
    required int totalItems,
    required int itemsPerDay,
  }) {
    if (progress >= 1.0) return 'Completed';
    if (itemsPerDay == 0) return 'Unknown';

    final remainingItems = (totalItems * (1 - progress)).ceil();
    final daysRemaining = (remainingItems / itemsPerDay).ceil();

    if (daysRemaining == 0) {
      return 'Today';
    } else if (daysRemaining == 1) {
      return '1 day';
    } else if (daysRemaining < 7) {
      return '$daysRemaining days';
    } else if (daysRemaining < 30) {
      final weeks = (daysRemaining / 7).ceil();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'}';
    } else {
      final months = (daysRemaining / 30).ceil();
      return '$months ${months == 1 ? 'month' : 'months'}';
    }
  }

  // Calculate daily average progress
  static double calculateDailyAverage({
    required int completedItems,
    required int daysActive,
  }) {
    if (daysActive == 0) return 0.0;
    return completedItems / daysActive;
  }

  // Predict completion date
  static DateTime? predictCompletionDate({
    required int totalItems,
    required int completedItems,
    required double averagePerDay,
  }) {
    if (averagePerDay == 0) return null;
    if (completedItems >= totalItems) return DateTime.now();

    final remainingItems = totalItems - completedItems;
    final daysRemaining = (remainingItems / averagePerDay).ceil();

    return DateTime.now().add(Duration(days: daysRemaining));
  }

  // Calculate completion rate (items per day)
  static double calculateCompletionRate({
    required int completedItems,
    required DateTime startDate,
  }) {
    final daysSinceStart = DateTime.now().difference(startDate).inDays;
    if (daysSinceStart == 0) return completedItems.toDouble();

    return completedItems / daysSinceStart;
  }

  // Get progress color based on performance
  static String getProgressColor(double progress, double expected) {
    if (progress >= expected * 1.2) {
      return 'excellent'; // Green
    } else if (progress >= expected) {
      return 'good'; // Light Green
    } else if (progress >= expected * 0.8) {
      return 'average'; // Orange
    } else {
      return 'below'; // Red
    }
  }

  // Calculate streak multiplier effect on progress
  static double calculateEffectiveProgress({
    required double baseProgress,
    required int streakDays,
  }) {
    final streakBonus = (streakDays * 0.01).clamp(0.0, 0.2); // Max 20% bonus
    return (baseProgress * (1 + streakBonus)).clamp(0.0, 1.0);
  }
}

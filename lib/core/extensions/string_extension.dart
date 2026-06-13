/// Extension methods on String for common operations
extension StringExtension on String {
  // Validation
  bool get isValidEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  bool get isNumeric => double.tryParse(this) != null;

  bool get isAlphanumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  // Capitalization
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  String get toTitleCase => capitalizeWords;

  // Trimming
  String get trimAll => replaceAll(RegExp(r'\s+'), '');

  String get removeExtraSpaces => replaceAll(RegExp(r'\s+'), ' ').trim();

  // Truncate
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  // Count
  int countOccurrences(String substring) {
    return substring.isEmpty
        ? 0
        : split(substring).length - 1;
  }

  // Reverse
  String get reversed => split('').reversed.join('');

  // Check empty
  bool get isEmptyOrNull => trim().isEmpty;

  bool get isNotEmptyAndNotNull => trim().isNotEmpty;
}

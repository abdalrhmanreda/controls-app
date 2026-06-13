import 'package:easy_localization/easy_localization.dart';
import 'package:control_app/gen/locale_keys.g.dart';

class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#?!@$%^&*-])[A-Za-z\d#?!@$%^&*-]{8,}$",
    ).hasMatch(password);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(phoneNumber);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'^(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^(?=.{8,})').hasMatch(password);
  }

  // Form Field Validators
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.name_is_required.tr();
    }
    if (value.trim().length < 3) {
      return LocaleKeys.name_too_short.tr();
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.email_is_required.tr();
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return LocaleKeys.email_should_be_valid.tr();
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.phone_is_required.tr();
    }
    if (value.trim().length < 10) {
      return LocaleKeys.phone_should_be_valid.tr();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.password_is_required.tr();
    }
    if (!hasMinLength(value)) {
      return LocaleKeys.password_min_length.tr();
    }
    if (!isPasswordValid(value)) {
      return LocaleKeys.password_should_be_strong.tr();
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.password_is_required.tr();
    }
    if (value != password) {
      return 'Passwords do not match'; // Add to locale keys if needed
    }
    return null;
  }

  static String? validateCarType(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.car_type_is_required.tr();
    }
    return null;
  }

  static String? validateCarNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.car_number_is_required.tr();
    }
    return null;
  }
}

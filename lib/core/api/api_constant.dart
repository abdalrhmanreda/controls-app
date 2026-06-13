class ApiConstant {
  static const String baseUrl = 'http://127.0.0.1:8000/';
  static const String loginEndpoint = 'auth/login/';
  static const String registerEndpoint = 'auth/register/';
  static const String verifyCodeEndpoint = 'auth/verify/';
  static const String resendCodeEndpoint = 'auth/resend-code/';
  static const String profileEndpoint = 'auth/profile/';
  static const String updateProfileEndpoint = 'auth/profile/update/';
  static const String changePasswordEndpoint = 'auth/change-password/';
  static const String logoutEndpoint = 'auth/logout/';
  static const String forgotPasswordEndpoint = 'auth/forgot-password/';
  static const String verifyResetCodeEndpoint = 'auth/verify-reset-code/';
  static const String resetPasswordEndpoint = 'auth/reset-password/';
  static const String garagesEndpoint = 'garages/';
  static const String garageDetailsEndpoint = 'garages/{id}/';
  static const String favoriteEndpoint = 'garages/favorites/{id}/';
  static const String favoritesListEndpoint = 'garages/favorites/';
  static const String slotsEndpoint = 'slots/garage/{id}/';
  static const String searchGaragesEndpoint = 'garages/search/';
  static const String chargeEndpoint = 'payments/charge/';

  static const String bookingsEndpoint = 'bookings/';
  static const String updateBookingEndpoint = 'bookings/update/{id}/';
  static const String createBookingEndpoint = 'bookings/create/';
  static const String contactUsEndpoint = 'contact-us/';

  static const String notificationsEndpoint = 'notifications/';
  static const String markReadEndpoint = 'notifications/{id}/mark-read/';
  static const String markAllReadEndpoint = 'notifications/mark-all-read/';
  static const String deleteNotificationEndpoint = 'notifications/{id}/delete/';
  static const String deleteAllNotificationsEndpoint =
      'notifications/delete-all/';

  static const String addCarEndpoint = 'cars/add/';
  static const String updateCarEndpoint = 'cars/update/{id}/';
  static const String deleteCarEndpoint = 'cars/delete/{id}/';
}

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  static FlutterSecureStorage? _secureStorageInstance;
  static const _channel = MethodChannel('tech.codex.shared_auth/token');

  static Future<FlutterSecureStorage> _getSecureStorage() async {
    if (_secureStorageInstance != null) return _secureStorageInstance!;

    String groupId = 'ABDSDa125.com.codex.shared';
    try {
      if (Platform.isIOS) {
        final String? resolvedGroupId = await _channel.invokeMethod<String>('getSharedKeychainGroupId');
        if (resolvedGroupId != null && resolvedGroupId.isNotEmpty) {
          groupId = resolvedGroupId;
          print('SecureStorageHelper: Resolved iOS Shared Keychain Group ID: $groupId');
        }
      }
    } catch (e) {
      print('SecureStorageHelper: Error resolving shared keychain group: $e');
    }

    _secureStorageInstance = FlutterSecureStorage(
      iOptions: IOSOptions(
        groupId: groupId,
      ),
    );
    return _secureStorageInstance!;
  }

  // Save access token
  static Future<void> saveAccessToken(String token) async {
    try {
      final secureStorage = await _getSecureStorage();
      print('SecureStorageHelper: Writing access_token to shared Keychain...');
      await secureStorage.write(key: _accessTokenKey, value: token);
      print('SecureStorageHelper: Successfully wrote access_token: "$token"');
    } catch (e) {
      print('SecureStorageHelper: Failed to write access_token. Error: $e');
    }
  }

  // Save refresh token
  static Future<void> saveRefreshToken(String token) async {
    try {
      final secureStorage = await _getSecureStorage();
      print('SecureStorageHelper: Writing refresh_token to shared Keychain...');
      await secureStorage.write(key: _refreshTokenKey, value: token);
      print('SecureStorageHelper: Successfully wrote refresh_token: "$token"');
    } catch (e) {
      print('SecureStorageHelper: Failed to write refresh_token. Error: $e');
    }
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    try {
      final secureStorage = await _getSecureStorage();
      print('SecureStorageHelper: Reading access_token from shared Keychain...');
      final token = await secureStorage.read(key: _accessTokenKey);
      print('SecureStorageHelper: Read access_token from shared Keychain: "$token"');
      return token;
    } catch (e) {
      print('SecureStorageHelper: Failed to read access_token from shared Keychain. Error: $e');
      return null;
    }
  }

  // Get refresh token
  static Future<String?> getRefreshToken() async {
    try {
      final secureStorage = await _getSecureStorage();
      print('SecureStorageHelper: Reading refresh_token from shared Keychain...');
      final token = await secureStorage.read(key: _refreshTokenKey);
      print('SecureStorageHelper: Read refresh_token from shared Keychain: "$token"');
      return token;
    } catch (e) {
      print('SecureStorageHelper: Failed to read refresh_token from shared Keychain. Error: $e');
      return null;
    }
  }

  // Clear access token
  static Future<void> clearAccessToken() async {
    try {
      final secureStorage = await _getSecureStorage();
      print('SecureStorageHelper: Deleting access_token from shared Keychain...');
      await secureStorage.delete(key: _accessTokenKey);
      print('SecureStorageHelper: Successfully deleted access_token');
    } catch (e) {
      print('SecureStorageHelper: Failed to delete access_token. Error: $e');
    }
  }

  // Clear refresh token
  static Future<void> clearRefreshToken() async {
    try {
      final secureStorage = await _getSecureStorage();
      print('SecureStorageHelper: Deleting refresh_token from shared Keychain...');
      await secureStorage.delete(key: _refreshTokenKey);
      print('SecureStorageHelper: Successfully deleted refresh_token');
    } catch (e) {
      print('SecureStorageHelper: Failed to delete refresh_token. Error: $e');
    }
  }

  // Clear all secure storage
  static Future<void> clearAll() async {
    try {
      final secureStorage = await _getSecureStorage();
      print('SecureStorageHelper: Clearing all keys from shared Keychain...');
      await secureStorage.deleteAll();
      print('SecureStorageHelper: Successfully cleared all keys');
    } catch (e) {
      print('SecureStorageHelper: Failed to clear all keys. Error: $e');
    }
  }
}

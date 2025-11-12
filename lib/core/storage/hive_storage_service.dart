import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

/// Hive storage service for storing non-sensitive data
@lazySingleton
class HiveStorageService {
  static const String _boxName = 'umbrella_box';
  Box? _box;

  /// Initialize Hive
  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  /// Get box instance
  Box get box {
    if (_box == null || !_box!.isOpen) {
      throw Exception('Hive box is not initialized');
    }
    return _box!;
  }

  /// Write data to Hive
  Future<void> write<T>({required String key, required T value}) async {
    await box.put(key, value);
  }

  /// Read data from Hive
  T? read<T>({required String key, T? defaultValue}) {
    return box.get(key, defaultValue: defaultValue) as T?;
  }

  /// Delete data from Hive
  Future<void> delete({required String key}) async {
    await box.delete(key);
  }

  /// Check if key exists
  bool containsKey({required String key}) {
    return box.containsKey(key);
  }

  /// Delete all data from Hive
  Future<void> deleteAll() async {
    await box.clear();
  }

  /// Get all keys
  Iterable<dynamic> getAllKeys() {
    return box.keys;
  }

  /// Get all values
  Iterable<dynamic> getAllValues() {
    return box.values;
  }

  // User Profile Methods
  Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    await write(key: 'user_profile', value: profile);
  }

  Map<String, dynamic>? getUserProfile() {
    return read<Map>(key: 'user_profile') as Map<String, dynamic>?;
  }

  Future<void> deleteUserProfile() async {
    await delete(key: 'user_profile');
  }

  // Settings Methods
  Future<void> saveThemeMode(String mode) async {
    await write(key: 'theme_mode', value: mode);
  }

  String getThemeMode({String defaultValue = 'system'}) {
    return read<String>(key: 'theme_mode', defaultValue: defaultValue) ??
        defaultValue;
  }

  Future<void> saveLanguageCode(String code) async {
    await write(key: 'language_code', value: code);
  }

  String getLanguageCode({String defaultValue = 'en'}) {
    return read<String>(key: 'language_code', defaultValue: defaultValue) ??
        defaultValue;
  }

  Future<void> saveNotificationsEnabled(bool enabled) async {
    await write(key: 'notifications_enabled', value: enabled);
  }

  bool getNotificationsEnabled({bool defaultValue = true}) {
    return read<bool>(
          key: 'notifications_enabled',
          defaultValue: defaultValue,
        ) ??
        defaultValue;
  }

  // Onboarding Methods
  Future<void> setOnboardingCompleted(bool completed) async {
    await write(key: 'is_onboarding_completed', value: completed);
  }

  bool isOnboardingCompleted() {
    return read<bool>(
          key: 'is_onboarding_completed',
          defaultValue: false,
        ) ??
        false;
  }

  // Session Methods
  Future<void> saveLastActiveTime(DateTime time) async {
    await write(key: 'last_active_time', value: time.toIso8601String());
  }

  DateTime? getLastActiveTime() {
    final timeStr = read<String>(key: 'last_active_time');
    if (timeStr != null) {
      return DateTime.tryParse(timeStr);
    }
    return null;
  }

  // Close box
  Future<void> close() async {
    await _box?.close();
  }
}

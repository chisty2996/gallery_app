import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Secure storage service for storing sensitive data
@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageService(this._secureStorage);

  /// Write data to secure storage
  Future<void> write({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Read data from secure storage
  Future<String?> read({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  /// Delete data from secure storage
  Future<void> delete({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  /// Check if key exists
  Future<bool> containsKey({required String key}) async {
    final value = await read(key: key);
    return value != null;
  }

  /// Delete all data from secure storage
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  /// Read all data from secure storage
  Future<Map<String, String>> readAll() async {
    return await _secureStorage.readAll();
  }

  // Authentication Methods
  Future<void> saveAccessToken(String token) async {
    await write(key: 'access_token', value: token);
  }

  Future<String?> getAccessToken() async {
    return await read(key: 'access_token');
  }

  Future<void> deleteAccessToken() async {
    await delete(key: 'access_token');
  }

  Future<void> saveRefreshToken(String token) async {
    await write(key: 'refresh_token', value: token);
  }

  Future<String?> getRefreshToken() async {
    return await read(key: 'refresh_token');
  }

  Future<void> deleteRefreshToken() async {
    await delete(key: 'refresh_token');
  }

  Future<void> saveGuestId(String guestId) async {
    await write(key: 'guest_id', value: guestId);
  }

  Future<String?> getGuestId() async {
    return await read(key: 'guest_id');
  }

  Future<void> deleteGuestId() async {
    await delete(key: 'guest_id');
  }

  // Clear all auth data
  Future<void> clearAuthData() async {
    await deleteAccessToken();
    await deleteRefreshToken();
    await deleteGuestId();
  }
}

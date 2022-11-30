abstract class StorageService {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> removeToken();
  Future<String?> getUserId();
  Future<void> saveUserId(String userId);
  Future<void> removeUserId();
}
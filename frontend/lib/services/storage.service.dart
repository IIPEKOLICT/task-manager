abstract class StorageService {
  Future<String?> getTokenOrNull();
  Future<void> saveToken(String token);
  Future<void> removeToken();
  Future<String?> getUserIdOrNull();
  Future<void> saveUserId(String userId);
  Future<void> removeUserId();
}

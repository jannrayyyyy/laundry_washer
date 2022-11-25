abstract class LocalDataSource {
  Future<void> storeUid({required String uid, String? logUid});
  Future<bool> userCheck();
  Future<void> removeUid();
}

abstract class LocalDataSource {
  Future<void> storeUid({required String uid});
  Future<bool> userCheck();
}

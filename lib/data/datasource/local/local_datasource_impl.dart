import 'package:general/general.dart';
import 'package:laundry_washer/data/datasource/local/local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final sharedPrefs = SharedPreferences.getInstance();

  @override
  Future<void> storeUid({required String uid}) async {
    final prefs = await sharedPrefs;
    await prefs.setString('uid', uid);
  }

  @override
  Future<bool> userCheck() async {
    final prefs = await sharedPrefs;
    final uid = prefs.getString('uid');
    show('uid: $uid');
    if (uid != null) {
      return true;
    } else {
      return false;
    }
  }
}

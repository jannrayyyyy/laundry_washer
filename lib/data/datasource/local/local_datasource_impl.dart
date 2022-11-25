import 'package:general/general.dart';
import 'package:laundry_washer/data/datasource/local/local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final sharedPrefs = SharedPreferences.getInstance();

  @override
  Future<void> storeUid({required String uid, String? logUid}) async {
    final prefs = await sharedPrefs;
    await prefs.setString('uid', uid);
    await prefs.setString('logUid', logUid ?? '');
  }

  @override
  Future<bool> userCheck() async {
    final prefs = await sharedPrefs;
    final uid = prefs.getString('uid');
    final logUid = prefs.getString('logUid');
    show('uid: $uid');
    if (uid != null && logUid != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> removeUid() async {
    final prefs = await sharedPrefs;
    await prefs.remove('uid');
    await prefs.remove('logUid');
  }
}

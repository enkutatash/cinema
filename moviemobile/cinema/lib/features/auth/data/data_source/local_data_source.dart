import 'package:shared_preferences/shared_preferences.dart';
abstract class LocalDataSource {
  Future<void> saveToken(String token);
  Future<String> getToken();
}

class LocalDataSourceImp extends LocalDataSource {
  final SharedPreferences sharedPreferences;
  LocalDataSourceImp({required this.sharedPreferences});
  @override
  Future<String> getToken() async {
    return sharedPreferences.getString('token') ?? '';
  }

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString('token', token);
  }
}


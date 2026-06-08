import 'dart:convert';

import 'package:dance_fever/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<bool> clearCachedUser();
}

class AuthLocalDatasourceImpl extends AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String cachedUser = 'cached_user';

  AuthLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString(cachedUser, json.encode(user.toJson()));
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = sharedPreferences.getString(cachedUser);

    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    } else {
      return null;
    }
  }

  @override
  Future<bool> clearCachedUser() async {
    return await sharedPreferences.remove(cachedUser);
  }
}

import 'package:authentication_repository/src/models/user_credentials.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:shared_preferences_manager/shared_preferences_manager.dart';
import 'models/user.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final SharedPreferencesManager _sharedPreferencesManager =
      SharedPreferencesManager();
  final dio = Dio();

  Stream<User> retrieveCurrentUser() {
    return Stream.fromFuture(_sharedPreferencesManager
        .getString('token')
        .then((token) => User(token: token)));
  }

  User get currentUser {
    final getSharedPreferences = _sharedPreferencesManager.getString('token');

    if (getSharedPreferences.toString() != "") {
      return User(token: getSharedPreferences.toString());
    }

    return User.empty;
  }

  Future<firebase_auth.UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final firebase_auth.OAuthCredential facebookAuthCredential =
          firebase_auth.FacebookAuthProvider.credential(
              loginResult.accessToken!.token);

      return _auth.signInWithCredential(facebookAuthCredential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw firebase_auth.FirebaseAuthException(
          code: e.code, message: e.message);
    }
  }

  Future<UserCredentials> signInWithEmailandPassword(User user) async {
    try {
      final Response response = await dio.post(
          'http://interview.advisoryapps.com/index.php/login',
          data: {'email': user.email, 'password': user.password});

      final userCredentials = UserCredentials.fromJson(response.data);

      await _sharedPreferencesManager.putString(
          'token', userCredentials.token!);

      return userCredentials;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    _sharedPreferencesManager.putString("token", "");
  }
}

import 'dart:async';

import 'package:chopper/chopper.dart' show Response;
import 'package:focial/models/auth.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/shared_prefs.dart';
import 'package:focial/utils/server_responses.dart';

enum AuthState { LoggedIn, Busy, LoggedOut }

class AuthService {
  final api = find<APIService>().api;

  StreamController<AuthState> _authStream = StreamController();

  Sink<AuthState> get _authStateSink => _authStream.sink;

  Stream<AuthState> get authState => _authStream.stream;

  Auth authData = Auth();

  Future<Auth> init() async {
    await SharedPrefs.init();
    String accessToken = SharedPrefs.getString(ACCESS_TOKEN);
    String refreshToken = SharedPrefs.getString(REFRESH_TOKEN);
    authData =
        authData.copyWith(accessToken: accessToken, refreshToken: refreshToken);
    _authStateSink
        .add(authData.isLoggedIn ? AuthState.LoggedIn : AuthState.LoggedOut);

    return authData;
  }

  void dispose() {
    _authStream.sink.close();
    _authStream.close();
  }

  Future<Response> register(
      {String name, String email, String password}) async {
    final response = await api.register(
      name: name,
      email: email,
      password: password,
    );
    return response;
  }

  Future<Response> login({String email, String password}) async {
    _authStateSink.add(AuthState.Busy);
    final response = await api.login(
      email: email,
      password: password,
    );
    if (response.isSuccessful) {
      _authStateSink.add(AuthState.LoggedIn);
    } else {
      _authStateSink.add(AuthState.LoggedOut);
    }
    await storeAuthTokens(response.headers);
    return response;
  }

  Future<Response> resendAccountVerificationLink(
      {String email, String password}) async {
    final response = await api.resendAccountVerifyLink(
      email: email,
      password: password,
    );
    return response;
  }

  Future<Response> sendPasswordResetCode(String email) async {
    final response = await api.sendPasswordResetCode(email: email);
    return response;
  }

  Future<Response> resendPasswordResetCode(String email) async {
    final response = await api.resendPasswordResetCode(email: email);
    return response;
  }

  Future<void> storeAuthTokens(Map<String, String> headers) async {
    authData = authData.copyWith(
        accessToken: headers[ACCESS_TOKEN],
        refreshToken: headers[REFRESH_TOKEN]);
    await SharedPrefs.putString(ACCESS_TOKEN, authData.accessToken);
    await SharedPrefs.putString(REFRESH_TOKEN, authData.refreshToken);
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/login/post_login_resp.dart';
import '../../../core/app_export.dart';
import '../../../data/models/login/post_login_req.dart';
import '../../../data/repository/repository.dart';
import '../models/login_model.dart';
part 'login_event.dart';
part 'login_state.dart';

/// A bloc that manages the state of a Login according to the event that is dispatche
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialstate) : super(initialstate) {
    on<LoginInitialEvent>(_onInitialize);
    on<CreateLoginEvent>(_callLogin);
  }

  final _repository = Repository();

  var postLoginResp = PostLoginResp();

  _onInitialize(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
      ),
    );
  }

  ///Calls [{{baseUrl}}/api/v1/auth/login] with the provided event and emits the state.
  ///
  /// The [CreateLoginEvent] parameter is used for handling event data
  /// The [emit] parameter is used for emitting the state
  ///
  /// Throws an error if an error occurs during the API call process.
  FutureOr<void> _callLogin(
    CreateLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    var postLoginReq = PostLoginReq(
      email: state.emailController?.text ?? '',
      password: state.passwordController?.text ?? '',
    );
    await _repository.login(
      headers: {},
      requestData: postLoginReq.toJson(),
    ).then((value) async {
      postLoginResp = value;
      _onLoginSuccess(value, emit);
      event.onCreateLoginEventSuccess?.call();
    }).onError((error, stackTrace) {
      _onLoginError();
      event.onCreateLoginEventError?.call();
    });
  }

  void _onLoginSuccess(
    PostLoginResp resp,
    Emitter<LoginState> emit,
  ) {
    PrefUtils().setAccessToken(resp.data?.accessToken ?? '');
    PrefUtils().setRefreshToken(resp.data?.refreshToken ?? '');
    emit(
      state.copyWith(
        loginModelObj: state.loginModelObj?.copyWith(),
      ),
    );  
  }

  void _onLoginError() {}

}

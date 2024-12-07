import 'dart:io';
import 'package:dio/dio.dart';
import 'package:quizzfly_application_flutter/data/models/create_group/post_create_group_resp.dart';
import 'package:quizzfly_application_flutter/data/models/detail_quizzfly/get_detail_quizzfly_resp.dart';
import 'package:quizzfly_application_flutter/data/models/list_question/get_list_question_resp.dart';
import '../../core/app_export.dart';
import '../models/change_password/post_change_password_resp.dart';
import '../models/delete_user/post_request_delete_user_req.dart';
import '../models/library_quizzfly/get_library_quizzfly_resp.dart';
import '../models/login/post_login_resp.dart';
import '../models/my_group/get_my_group_resp.dart';
import '../models/register/post_register_resp.dart';
import '../models/my_user/get_my_user_resp.dart';
import '../models/update_profile/patch_update_profile_req.dart';
import '../models/update_quizzfly_setting/put_update_quizzfly_setting_resp.dart';
import '../models/upload_file/post_upload_file.dart';
import '../models/verify_delete_user/delete_verify_delete_user_resp.dart';
import 'network_interceptor.dart';

// ignore_for_file: must_be_immutable
class ApiClient {
  factory ApiClient() {
    return _apiClient;
  }
  ApiClient._internal();
  var url = "http://103.161.96.76:3000";
  static final ApiClient _apiClient = ApiClient._internal();

  final _dio =
      Dio(BaseOptions(connectTimeout: const Duration(seconds: 60), headers: {
    "Accept": "application/json",
    "Content-Type": "application/json",
  }))
        ..interceptors.add(NetworkInterceptor());

  ///method can be used for checking internet connection
  ///returns [bool] based on availability of internet
  Future isNetworkConnected() async {
    if (!await NetworkInfo().isConnected()) {
      throw NoInternetException('No Internet Found!');
    }
  }

  /// is true when the response status code is between 200 and 299
  ///
  /// user can modify this method with custom logics based on their API response
  bool isSuccessCall(Response response) {
    if (response.statusCode != null) {
      return response.statusCode! >= 200 && response.statusCode! <= 299;
    }
    return false;
  }

  /// Performs API call for {{baseUrl}}/api/v1/auth/login
  ///
  /// Sends a POST request to the server's '{{baseUrl}}/api/v1/auth/login' endpoint
  /// with the provided headers and request data
  /// Returns a [PostLoginResp] object representing the response.
  /// Throws an error if the request fails or an exception occurs.
  Future<PostLoginResp> login({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/v1/auth/login',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return PostLoginResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? PostLoginResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<PostRegisterResp> register({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/v1/auth/register',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return PostRegisterResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? PostRegisterResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<GetMyUserResp> getMyUser({
    Map<String, String> headers = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.get(
        '$url/api/v1/users/me',
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return GetMyUserResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? GetMyUserResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<GetMyUserResp> updateProfile({
    required PatchUpdateProfileReq requestData,
    Map<String, String> headers = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.patch(
        '$url/api/v1/users/profile/me',
        data: requestData.toJson(),
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return GetMyUserResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? GetMyUserResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<UploadFileResp> uploadFile({
    required File file,
    Map<String, String> headers = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();

      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      var response = await _dio.post(
        '$url/api/v1/files',
        data: formData,
        options: Options(headers: headers),
      );

      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return UploadFileResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? UploadFileResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<bool> postAuthForgotPassword({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/v1/auth/forgot-password',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      // Return true if status code is 204
      return response.statusCode == 204;
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  // Add this method to your ApiClient class
  Future<GetLibraryQuizzflyResp> getLibraryQuizzfly({
    Map<String, String> headers = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.get(
        '$url/api/v1/quizzfly',
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return GetLibraryQuizzflyResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? GetLibraryQuizzflyResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  // Add this method to your ApiClient class
  Future<GetMyGroupsResp> getMyGroup({
    Map<String, String> headers = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.get(
        '$url/api/v1/groups',
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return GetMyGroupsResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? GetMyGroupsResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<GetDetailQuizzflyResp> getDetailQuizzfly(String id) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      Response response = await _dio.get(
        '$url/api/v1/quizzfly/{$id}',
        options: Options(),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return GetDetailQuizzflyResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? GetDetailQuizzflyResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<PostChangePasswordResp> changePassword({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/v1/users/change-password',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return PostChangePasswordResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? PostChangePasswordResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<PostRequestDeleteUserResp> requestDeleteUser({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/v1/users/request-delete',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return PostRequestDeleteUserResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? PostRequestDeleteUserResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<DeleteVerifyDeleteUserResp> verifyDeleteUser({
    Map<String, String> headers = const {},
    Map<String, dynamic> queryParams = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      Response response = await _dio.delete(
        '$url/api/v1/users/verify-delete',
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return DeleteVerifyDeleteUserResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? DeleteVerifyDeleteUserResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<bool> logoutPost({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/v1/auth/logout',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      return response.statusCode == 204;
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<PutUpdateQuizzflySettingsResp> updateQuizzflySettings({
    Map<String, String> headers = const {},
    Map requestData = const {},
    String? id,
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.put(
        '$url/api/v1/quizzfly/$id/settings',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return PutUpdateQuizzflySettingsResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? PutUpdateQuizzflySettingsResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<GetListQuestionsResp> listQuestions({
    Map<String, String> headers = const {},
    Map requestData = const {},
    String? id,
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.get(
        '$url/api/v1/quizzfly/$id/questions',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return GetListQuestionsResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? GetListQuestionsResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<bool> deleteQuizzfly(
      {Map<String, String> headers = const {}, String? id}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      Response response = await _dio.delete(
        '$url/api/v1/quizzfly/$id',
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      return response.statusCode == 204;
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<bool> deleteMyGroup(
      {Map<String, String> headers = const {}, String? id}) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      Response response = await _dio.delete(
        '$url/api/v1/groups/$id',
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      return response.statusCode == 204;
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<PostLoginResp> loginWithGoogle({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/v1/auth/google',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return PostLoginResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? PostLoginResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<PostCreateGroupResp> createGroup({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/v1/groups',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return PostCreateGroupResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? PostCreateGroupResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

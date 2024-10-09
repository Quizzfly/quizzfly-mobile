import '../apiClient/api_client.dart';
import '../models/login/post_login_resp.dart';
import '../models/my_user/get_my_user_resp.dart';
import '../models/register/post_register_resp.dart';

/// Repository class for managing API requests.
///
/// This class provides a simplified interface for making the
/// API request using the [ApiClient] instance
class Repository {
  final _apiClient = ApiClient();
  Future<PostRegisterResp> register({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.register(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<PostLoginResp> login({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.login(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<GetMyUserResp> getMyUser(
      {Map<String, String> headers = const {}}) async {
    try {
      return await _apiClient.getMyUser(
        headers: headers,
      );
    } catch (e) {
      print('Error fetching user profile: $e');
      rethrow;
    }
  }
}

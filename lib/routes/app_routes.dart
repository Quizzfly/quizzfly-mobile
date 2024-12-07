import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/presentation/community_screen/community_screen.dart';
import 'package:quizzfly_application_flutter/presentation/home_screen/home_initial_page.dart';
import 'package:quizzfly_application_flutter/presentation/home_screen/home_screen.dart';
import 'package:quizzfly_application_flutter/presentation/my_group_screen/my_group_screen.dart';
import '../presentation/enter_pin_screen/enter_pin_screen.dart';
import '../presentation/input_nickname_screen/input_nick_name_screen.dart';
import '../presentation/quizzfly_setting_screen/quizzfly_setting_screen.dart';
import '../presentation/room_quiz_screen/room_quiz_screen.dart';
import '../presentation/waiting_room_screen/waiting_room_screen.dart';
import '../presentation/delete_account_screen/delete_account_screen.dart';
import '../presentation/edit_profile_screen/edit_profile_screen.dart';
import '../presentation/quizzfly_detail_screen/quizzfly_detail_screen.dart';
import '../presentation/library_screen/library_screen.dart';
import '../presentation/reset_password_screen/reset_password_screen.dart';
import '../presentation/change_password_screen/change_password_screen.dart';
import '../presentation/profile_setting_screen/profile_setting_screen.dart';
import '../presentation/forgot_password_screen/forgot_password_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/register_screen/register_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  static const String initialRoute = '/initialRoute';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String resetPassWordScreen = '/reset_password_screen';
  static const String editProfileScreen = '/edit_profile_screen';
  static const String privacyScreen = '/privacy_screen';
  static const String profileSettingScreen = '/profile_setting_screen';
  static const String changePasswordScreen = '/change_password_screen';
  static const String libraryScreen = '/library_screen';
  static const String quizzflyDetailScreen = "/quizzfly_detail_screen";
  static const String deleteAccountScreen = '/delete_account_screen';
  static const String quizzflySetting = "/quizzfly_setting_screen";
  static const String enterPinScreen = "/enter_pin_screen";
  static const String inputNickname = "/input_nickname_screen";
  static const String waitingRoom = "/waiting_room_screen";
  static const String leaderBoardScreen = "/leader_board_screen";
  static const String homeInitialPage = "/home_initial_page";
  static const String communityScreen = "/community_screen";
  static const String homeScreen = "/home_screen";
  static const String myGroupScreen = "/my_group_screen";

  static Map<String, WidgetBuilder> get routes => {
        loginScreen: LoginScreen.builder,
        registerScreen: RegisterScreen.builder,
        forgotPasswordScreen: ForgotPasswordScreen.builder,
        changePasswordScreen: ChangePasswordScreen.builder,
        profileSettingScreen: ProfileSettingScreen.builder,
        resetPassWordScreen: ResetPasswordScreen.builder,
        libraryScreen: LibraryScreen.builder,
        quizzflyDetailScreen: QuizzflyDetailScreen.builder,
        deleteAccountScreen: DeleteAccountScreen.builder,
        quizzflySetting: QuizzflySettingScreen.builder,
        enterPinScreen: EnterPinScreen.builder,
        initialRoute: LoginScreen.builder,
        inputNickname: InputNicknameScreen.builder,
        waitingRoom: WaitingRoomScreen.builder,
        communityScreen: CommunityScreen.builder,
        homeInitialPage: HomeInitialPage.builder,
        homeScreen: HomeScreen.builder,
        myGroupScreen: MyGroupScreen.builder
      };
  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case initialRoute:
  //       return MaterialPageRoute(
  //         builder: (context) => initialRouteWidget(context),
  //       );
  //     // Add cases for other routes if needed
  //     default:
  //       return MaterialPageRoute(
  //         builder: (_) => const Scaffold(
  //           body: Center(child: Text('Route not found!')),
  //         ),
  //       );
  //   }
  // }
  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case initialRoute:
  //       return MaterialPageRoute(
  //         builder: (context) => initialRouteWidget(context),
  //       );
  //     // Add cases for other routes if needed
  //     default:
  //       return MaterialPageRoute(
  //         builder: (_) => const Scaffold(
  //           body: Center(child: Text('Route not found!')),
  //         ),
  //       );
  //   }
  // }

  // Custom method to handle slide transition navigation for specific routes
  static Future<T?> navigateWithSlide<T>(
    BuildContext context,
    WidgetBuilder builder, {
    bool replace = false,
    Duration duration = const Duration(milliseconds: 400),
    Offset begin = const Offset(1.0, 0.0),
    Curve curve = Curves.easeInOut,
  }) {
    final PageRoute<T> pageRoute = PageRouteBuilder<T>(
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const end = Offset.zero;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );

    if (replace) {
      return Navigator.pushReplacement(context, pageRoute);
    }
    return Navigator.push(context, pageRoute);
  }

  // Example screen-specific navigation methods using the generic method
  static Future<void> navigateToDeleteAccount(BuildContext context) {
    return navigateWithSlide(
      context,
      DeleteAccountScreen.builder,
    );
  }

  static Future<void> navigateToEditProfile(BuildContext context) {
    return navigateWithSlide(
      context,
      EditProfileScreen.builder,
    );
  }

  static Future<void> navigateToChangePassword(BuildContext context) {
    return navigateWithSlide(
      context,
      ChangePasswordScreen.builder,
    );
  }

  static Future<void> navigateToProfileSetting(BuildContext context) {
    return navigateWithSlide(
      context,
      ProfileSettingScreen.builder,
      // Example of customizing transition
      begin: const Offset(0.0, 1.0), // Slide up instead of right
    );
  }

  // Example of navigation with replacement (removes previous screen from stack)
  static Future<void> navigateToLogin(BuildContext context) {
    return navigateWithSlide(
      context,
      LoginScreen.builder,
      replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToForgotPasswordScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      ForgotPasswordScreen.builder,
      replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToRegisterScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      RegisterScreen.builder,
      replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToQuizzflyDetailScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      QuizzflyDetailScreen.builder,
      replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToQuizzflySettingScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      QuizzflySettingScreen.builder,
      replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToEnterPinScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      EnterPinScreen.builder, replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToInputNickNameScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      InputNicknameScreen.builder,
      replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToWaitingRoomScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      WaitingRoomScreen.builder, replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToRoomQuizScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      RoomQuizScreen.builder, replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToCommunityScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      CommunityScreen.builder, replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToHomeScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      HomeScreen.builder, replace: false, // Will replace current screen
    );
  }
}

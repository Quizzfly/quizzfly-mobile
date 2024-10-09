import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/presentation/change_password_screen/change_password_screen.dart';
import 'package:quizzfly_application_flutter/presentation/profile_setting_screen/profile_setting_screen.dart';
import '../presentation/edit_profile_screen/edit_profile_screen.dart';
import 'package:quizzfly_application_flutter/presentation/change_password_screen/change_password_screen.dart';
import 'package:quizzfly_application_flutter/presentation/profile_setting_screen/profile_setting_screen.dart';
import '../presentation/edit_profile_screen/edit_profile_screen.dart';
import '../presentation/forgot_password_screen/forgot_password_screen.dart';
// import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/privacy_screen/privacy_screen.dart';
import '../presentation/privacy_screen/privacy_screen.dart';
import '../presentation/register_screen/register_screen.dart';
import '../presentation/reset_password_screen/reset_password_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  // static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/initialRoute';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String resetPassWordScreen = '/reset_password_screen';
  static const String editProfileScreen = '/edit_profile_screen';
  static const String privacyScreen = '/privacy_screen';
  static const String profileSettingScreen = '/profile_setting_screen';
  static const String changePasswordScreen = '/change_password_screen';

  static Map<String, WidgetBuilder> get routes => {
        loginScreen: LoginScreen.builder,
        registerScreen: RegisterScreen.builder,
        forgotPasswordScreen: ForgotPasswordScreen.builder,
        // appNavigationScreen: AppNavigationScreen.builder,
        initialRoute: LoginScreen.builder,
        changePasswordScreen: ChangePasswordScreen.builder,
        profileSettingScreen : ProfileSettingScreen.builder,
      };

  // Custom method to handle slide transition navigation for specific routes
  static void navigateToRegisterScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration:
            const Duration(milliseconds: 400), // Set duration to 400ms
        pageBuilder: (context, animation, secondaryAnimation) =>
            RegisterScreen.builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right to left
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  static void navigateToForgotPasswordScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration:
            const Duration(milliseconds: 400), // Set duration to 400ms
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProfileSettingScreen.builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right to left
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}

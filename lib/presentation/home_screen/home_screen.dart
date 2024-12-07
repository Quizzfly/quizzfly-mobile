import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/presentation/library_screen/library_screen.dart';
import 'package:quizzfly_application_flutter/presentation/my_group_screen/my_group_screen.dart';
import 'package:quizzfly_application_flutter/presentation/profile_setting_screen/profile_setting_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'bloc/home_bloc.dart';
import 'home_initial_page.dart';
import 'models/home_model.dart';

// ignore_for_file: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(HomeState(
        homeModelObj: const HomeModel(),
      ))
        ..add(HomeInitialEvent()),
      child: HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700.withOpacity(1),
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.homeInitialPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) =>
                getCurrentPage(context, routeSetting.name!),
            transitionDuration: const Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: double.maxFinite,
          child: _buildBottomNavigationBar(context),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Navigator.pushNamed(
              navigatorKey.currentContext!, getCurrentRoute(type));
        },
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeInitialPage;
      case BottomBarEnum.Library:
        return AppRoutes.libraryScreen;
      case BottomBarEnum.Group:
        return AppRoutes.myGroupScreen;
      case BottomBarEnum.Account:
        return AppRoutes.profileSettingScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.homeInitialPage:
        return HomeInitialPage.builder(context);
      case AppRoutes.libraryScreen:
        return LibraryScreen.builder(context);
      case AppRoutes.myGroupScreen:
        return MyGroupScreen.builder(context);
      case AppRoutes.profileSettingScreen:
        return ProfileSettingScreen.builder(context);
      default:
        return const DefaultWidget();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/validation_functions.dart';
import '../../../domain/googleAuth/google_auth_helper.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'bloc/register_bloc.dart';
import 'models/register_model.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(RegisterState(
        registerModelObj: const RegisterModel(),
      ))
        ..add(RegisterInitialEvent()),
      child: RegisterScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 24.h,
                top: 20.h,
                right: 24.h,
              ),
              child: Form(
                key: _formKey, // Use the class-level _formKey here
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    CustomImageView(
                      imagePath: ImageConstant.imageLogo,
                      height: 180.h,
                      width: double.maxFinite,
                      radius: BorderRadius.circular(
                        20.h,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildWelcomeSection(context),
                    SizedBox(height: 18.h),
                    _buildNameInputSection(context),
                    SizedBox(height: 12.h),
                    _buildEmailInputSection(context),
                    SizedBox(height: 12.h),
                    _buildPasswordInputSection(context),
                    SizedBox(height: 12.h),
                    _buildConfirmPasswordInputSection(context),
                    SizedBox(height: 16.h),
                    CustomElevatedButton(
                      height: 44.h,
                      text: "lbl_sign_up".tr,
                      buttonStyle: CustomButtonStyles.fillPrimaryRadius12,
                      buttonTextStyle: theme.textTheme.bodyLarge!,
                      onPressed: () => {onTapSignUpButton(context)},
                    ),
                    SizedBox(height: 40.h),
                    _buildAlternativeSignInSection(context),
                    SizedBox(height: 22.h),
                    CustomElevatedButton(
                      height: 40.h,
                      text: "lbl_google".tr,
                      leftIcon: Container(
                        margin: EdgeInsets.only(right: 16.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imageGoogle,
                          height: 24.h,
                          width: 24.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      buttonStyle: CustomButtonStyles.fillGray,
                      buttonTextStyle:
                          CustomTextStyles.bodyLargeErrorContainer_1,
                      onPressed: () {
                        onTapGoogle(context);
                      },
                    ),
                    SizedBox(height: 26.h),
                    _buildConfirmationSection(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildWelcomeSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "lbl_register_account".tr,
                  style: CustomTextStyles.headlineSmallSFProRoundedGray90003,
                ),
                const WidgetSpan(
                  child:
                      SizedBox(width: 10), // Add a SizedBox to simulate padding
                ),
                TextSpan(
                  text: "lbl".tr,
                  style: CustomTextStyles
                      .headlineSmallSFProRoundedGray90003Regular,
                )
              ],
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 14.h),
          Text(
            "msg_today_is_a_new_day".tr,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:
                CustomTextStyles.bodyMediumSFProDisplayErrorContainer.copyWith(
              height: 1.60,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildNameInputSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_name".tr,
                  style: CustomTextStyles.bodyMediumRobotoGray90003,
                )
              ],
            ),
          ),
          SizedBox(height: 4.h),
          BlocSelector<RegisterBloc, RegisterState, TextEditingController?>(
            selector: (state) => state.nameController,
            builder: (context, nameController) {
              return CustomTextFormField(
                controller: nameController,
                hintText: "lbl_enter_your_name".tr,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.h,
                  vertical: 12.h,
                ),
                validator: (value) {
                  if (value == null || !isText(value, isRequired: true)) {
                    return "err_msg_please_enter_valid_name".tr;
                  }
                  return null;
                },
              );
            },
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailInputSection(BuildContext context) {
    return SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "lbl_email".tr,
                    style: CustomTextStyles.bodyMediumRobotoGray90003,
                  )
                ],
              ),
            ),
            SizedBox(height: 4.h),
            BlocSelector<RegisterBloc, RegisterState, TextEditingController?>(
              selector: (state) => state.emailController,
              builder: (context, emailController) {
                return CustomTextFormField(
                  controller: emailController,
                  hintText: "msg_example_email_com".tr,
                  textInputType: TextInputType.emailAddress,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.h,
                    vertical: 12.h,
                  ),
                  validator: (value) {
                    if (value == null ||
                        (!isValidEmail(value, isRequired: true))) {
                      return "err_msg_please_enter_valid_email".tr;
                    }
                    return null;
                  },
                );
              },
            )
          ],
        ));
  }

  //Section widget
  Widget _buildPasswordInputSection(BuildContext context) {
    bool obscureText = true; // Variable to track password visibility

    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "lbl_password".tr,
                style: CustomTextStyles.bodyMediumRobotoGray90003,
              ),
              SizedBox(height: 4.h),
              BlocSelector<RegisterBloc, RegisterState, TextEditingController?>(
                selector: (state) => state.passwordController,
                builder: (context, passwordController) {
                  return CustomTextFormField(
                    controller: passwordController,
                    hintText: "msg_at_least_8_characters".tr,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    obscureText:
                        obscureText, // Use the boolean to toggle visibility
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.h,
                      vertical: 12.h,
                    ),
                    suffix: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        // Toggle password visibility
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "err_msg_please_enter_valid_password"
                            .tr; // Validate null
                      } else if (value.length < 8) {
                        return "msg_at_least_8_characters"
                            .tr; // Validate length < 8
                      }
                      return null; // Return null if validation passes
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //Section widget
  Widget _buildConfirmPasswordInputSection(BuildContext context) {
    bool obscureText = true; // Variable to track password visibility

    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "lbl_confirm_password".tr,
                style: CustomTextStyles.bodyMediumRobotoGray90003,
              ),
              SizedBox(height: 4.h),
              BlocSelector<RegisterBloc, RegisterState, TextEditingController?>(
                selector: (state) => state.confirmPasswordController,
                builder: (context, confirmNewPasswordController) {
                  return CustomTextFormField(
                    controller: confirmNewPasswordController,
                    hintText: "msg_at_least_8_characters".tr,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    obscureText:
                        obscureText, // Use the boolean to toggle visibility
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.h,
                      vertical: 12.h,
                    ),
                    suffix: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        // Toggle password visibility
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "err_msg_please_enter_valid_password"
                            .tr; // Validate null
                      } else if (value !=
                          context
                              .read<RegisterBloc>()
                              .state
                              .passwordController
                              ?.text) {
                        return "err_msg_passwords_do_not_match"
                            .tr; // Validation to check if passwords match
                      }
                      return null; // Return null if validation passes
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildAlternativeSignInSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Divider(
                color: appTheme.blueGray100,
              ),
            ),
          ),
          SizedBox(width: 16.h),
          Align(
            alignment: Alignment.center,
            child: Text(
              "lbl_or_sign_in_with".tr,
              style: CustomTextStyles.bodyMediumRobotoBlueGray800,
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Divider(
                color: appTheme.blueGray100,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildConfirmationSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 14.h),
      padding: EdgeInsets.only(right: 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "msg_don_t_you_have_an2".tr,
                  style: CustomTextStyles.bodyLargeErrorContainer,
                ),
                const WidgetSpan(
                  child:
                      SizedBox(width: 10), // Add a SizedBox to simulate padding
                ),
                TextSpan(
                  text: "lbl_sign_up".tr,
                  style: CustomTextStyles.bodyLargePrimary,
                )
              ],
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(right: 26.h),
            child: Text(
              "msg_2023_all_rights".tr,
              style: CustomTextStyles.bodyMediumRobotoBlueGray300,
            ),
          )
        ],
      ),
    );
  }

  /// Calls the {{baseUrl}}/api/v1/auth/register API and triggers a [CreateRegisterEvent] event on the [RegisterBloc] bloc.
  /// /// Validates the form and triggers a [CreateRegisterEvent] event on the [RegisterBloc] bloc if the form is valid.
  /// The [BuildContext] parameter represents current [BuildContext]
  onTapSignUpButton(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterBloc>().add(
            CreateRegisterEvent(
              onCreateRegisterEventSuccess: () {
                _onRegisterEventSuccess(context);
              },
              onCreateRegisterEventError: () {
                _onRegisterEventError(context);
              },
            ),
          );
    }
  }

  /// Navigates to the loginScreen when the action is triggered.
  void _onRegisterEventSuccess(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.loginScreen,
    );
  }

  /// Displays a toast message using the Fluttertoast library.
  void _onRegisterEventError(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'User accounts already exist',
      ),
    );
  }

  onTapGoogle(BuildContext context) async {
    await GoogleAuthHelper().googleSignInProcess().then((googleUser) {
      if (googleUser != null) {
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('user data is empty')));
      }
    }).catchError((onError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(onError.toString())));
    });
  }
}

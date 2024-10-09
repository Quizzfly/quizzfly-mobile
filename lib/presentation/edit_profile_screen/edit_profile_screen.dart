import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/edit_profile_bloc.dart';
import 'models/edit_profile_model.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key})
      : super(
          key: key,
        );
  static Widget builder(BuildContext context) {
    return BlocProvider<EditProfileBloc>(
      create: (context) => EditProfileBloc(EditProfileState(
        editProfileModelObj: EditProfileModel(),
      ))
        ..add(EditProfileInitialEvent()),
      child: EditProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(bottom: 32.h),
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 22.h),
              child: Column(
                children: [
                  _buildUserInformationForm(context),
                  SizedBox(height: 4.h),
                  _buildAccountDetailsForm(context),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 290.h,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "lbl_delete_account".tr,
                            style: CustomTextStyles.bodyMediumErrorContainer
                                .copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: CustomTextStyles
                                  .bodyMediumErrorContainer.color,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          TextSpan(
                            text: "\n\n",
                            style: CustomTextStyles.bodyMediumBlack900_1,
                          ),
                          TextSpan(
                            text: "msg_if_you_delete_your".tr,
                            style: CustomTextStyles.bodyMediumRobotoGray90003,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 104.h)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return BlocSelector<EditProfileBloc, EditProfileState, bool?>(
      selector: (state) => state.isSaveButtonEnabled,
      builder: (context, isSaveButtonEnabled) {
        return CustomElevatedButton(
          height: 30.h,
          width: 66.h,
          text: "lbl_save".tr,
          buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
          buttonStyle: isSaveButtonEnabled == true
              ? CustomButtonStyles.fillPrimary
              : CustomButtonStyles.fillBlackGray,
          onPressed: isSaveButtonEnabled == true ? () {} : null,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildUsernameInput(BuildContext context) {
    return BlocSelector<EditProfileBloc, EditProfileState,
        TextEditingController?>(
      selector: (state) => state.usernameInputController,
      builder: (context, usernameInputController) {
        return CustomTextFormField(
          controller: usernameInputController,
          hintText: "Enter your username",
          contentPadding: EdgeInsets.all(12.h),
          onChanged: (value) {
            _onInputChanged(context);
          },
        );
      },
    );
  }

  Widget _buildNameInput(BuildContext context) {
    return BlocSelector<EditProfileBloc, EditProfileState,
        TextEditingController?>(
      selector: (state) => state.nameInputController,
      builder: (context, nameInputController) {
        return CustomTextFormField(
          controller: nameInputController,
          hintText: "Enter your name",
          contentPadding: EdgeInsets.all(12.h),
          onChanged: (value) {
            _onInputChanged(context);
          },
        );
      },
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return BlocSelector<EditProfileBloc, EditProfileState,
        TextEditingController?>(
      selector: (state) => state.emailInputController,
      builder: (context, emailInputController) {
        return CustomTextFormField(
          controller: emailInputController,
          hintText: "Enter your email",
          contentPadding: EdgeInsets.all(12.h),
          onChanged: (value) {
            _onInputChanged(context);
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildUserInformationForm(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder5,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.1),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "msg_user_information".tr,
                  style: CustomTextStyles.bodyMediumRobotoFontGray90003,
                ),
                _buildSaveButton(context),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              color: appTheme.indigo50,
            ),
          ),
          SizedBox(height: 12.h),
          DottedBorder(
            color: appTheme.black900,
            padding: EdgeInsets.only(
              left: 0.5.h,
              top: 0.5.h,
              right: 0.5.h,
              bottom: 0.5.h,
            ),
            strokeWidth: 0.5.h,
            radius: Radius.circular(5),
            borderType: BorderType.RRect,
            dashPattern: [1, 1],
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 18.h,
                vertical: 24.h,
              ),
              decoration: BoxDecoration(
                color: appTheme.gray100,
                borderRadius: BorderRadiusStyle.roundedBorder5,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imagePhoto,
                    height: 24.h,
                    width: 30.h,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "lbl_add_picture".tr,
                    style: CustomTextStyles.titleSmallRobotoSansBlack900,
                  ),
                  SizedBox(height: 6.h)
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_username".tr,
                  style: CustomTextStyles.bodyMediumRobotoGray90003,
                ),
                SizedBox(height: 6.h),
                _buildUsernameInput(context),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_name".tr,
                  style: CustomTextStyles.bodyMediumRobotoGray90003,
                ),
                SizedBox(height: 6.h),
                _buildNameInput(context),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_email".tr,
                  style: CustomTextStyles.bodyMediumRobotoGray90003,
                ),
                SizedBox(height: 6.h),
                _buildEmailInput(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Method to handle input changes and dispatch event to Bloc
  void _onInputChanged(BuildContext context) {
    final bloc = context.read<EditProfileBloc>();
    bloc.add(TextFieldChangedEvent(
        bloc.state.usernameInputController?.text ?? '',
        bloc.state.nameInputController?.text ?? '',
        bloc.state.emailInputController?.text ?? ''));
  }

  /// Section Widget
  Widget _buildOrganizationInput(BuildContext context) {
    return BlocSelector<EditProfileBloc, EditProfileState,
        TextEditingController?>(
      selector: (state) => state.organizationInputController,
      builder: (context, organizationInputController) {
        return CustomTextFormField(
          width: 126.h,
          controller: organizationInputController,
          textInputAction: TextInputAction.done,
          contentPadding: EdgeInsets.all(12.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildAccountDetailsForm(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 18.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder5,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.1),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 24.h),
              child: Text(
                "lbl_account_detail".tr,
                style: CustomTextStyles.bodyMediumRobotoFontGray90003,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              color: appTheme.blueGray50,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 24.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lbl_organization".tr,
                        style: CustomTextStyles.bodyMediumRobotoGray90003,
                      ),
                      SizedBox(height: 4.h),
                      _buildOrganizationInput(context)
                    ],
                  ),
                ),
                SizedBox(
                  width: 126.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lbl_language".tr,
                        style: CustomTextStyles.bodyMediumRobotoGray90003,
                      ),
                      SizedBox(height: 6.h),
                      BlocSelector<EditProfileBloc, EditProfileState,
                          EditProfileModel?>(
                        selector: (state) => state.editProfileModelObj,
                        builder: (context, editProfileModelObj) {
                          return CustomDropDown(
                            icon: Container(
                              margin: EdgeInsets.only(left: 4.h),
                              child: CustomImageView(
                                imagePath: ImageConstant.imageArrowDown,
                                height: 16.h,
                                width: 16.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                            iconSize: 16.h,
                            hintText: "lbl_language".tr,
                            items: editProfileModelObj?.dropdownItemList ?? [],
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.h,
                              vertical: 12.h,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

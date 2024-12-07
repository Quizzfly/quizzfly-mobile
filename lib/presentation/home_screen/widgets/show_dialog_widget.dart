import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'dart:io';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../bloc/home_bloc.dart';

class ShowDialogWidget extends StatefulWidget {
  const ShowDialogWidget({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider.value(
      value: context.read<HomeBloc>(),
      child: const ShowDialogWidget(),
    );
  }

  @override
  // ignore: library_private_types_in_public_api
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialogWidget> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Widget _buildImageStack() {
    return Container(
      height: 200.h,
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 4.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20.h),
                  child: Image.file(
                    _selectedImage!,
                    height: 200.h,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return CustomImageView(
                        imagePath: ImageConstant.imgNotFound,
                        height: 250.h,
                        width: double.maxFinite,
                        radius: BorderRadius.circular(20.h),
                      );
                    },
                  ),
                )
              : CustomImageView(
                  imagePath: ImageConstant.imgNotFound,
                  height: 250.h,
                  width: double.maxFinite,
                  radius: BorderRadius.circular(20.h),
                ),
          CustomElevatedButton(
            height: 30.h,
            width: 160.h,
            text: "lbl_add_image".tr,
            margin: EdgeInsets.only(top: 90.h),
            buttonStyle: CustomButtonStyles.fillPrimaryRadius20,
            buttonTextStyle: CustomTextStyles.labelLargeWhiteA700,
            alignment: Alignment.topCenter,
            onPressed: _pickImage,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Create Group',
        style: CustomTextStyles.headlineSmallSFProRoundedGray90003,
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageStack(),
              SizedBox(height: 26.h),
              Text(
                "lbl_name".tr,
                style: CustomTextStyles.bodyMediumRobotoFontGray90003,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 6.h),
              CustomTextFormField(
                controller: _nameController,
                hintText: "lbl_enter_name".tr,
                hintStyle: CustomTextStyles.bodyMediumRobotoGray90003,
                contentPadding: EdgeInsets.all(12.h),
                borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL81,
                fillcolor: appTheme.whiteA700,
                validator: (value) {
                  if (value == null || !value.isNotEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),
              Text(
                "lbl_description".tr,
                style: CustomTextStyles.bodyMediumRobotoFontGray90003,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 4.h),
              CustomTextFormField(
                controller: _descriptionController,
                hintText: "lbl_enter_description".tr,
                hintStyle: CustomTextStyles.bodyMediumRobotoGray90003,
                textInputAction: TextInputAction.done,
                maxLines: 4,
                contentPadding: EdgeInsets.all(12.h),
                borderDecoration: TextFormFieldStyleHelper.outlineBlueGrayTL81,
                fillcolor: appTheme.whiteA700,
                validator: (value) {
                  if (value == null || !value.isNotEmpty) {
                    return "Description is required";
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomElevatedButton(
              height: 40.h,
              width: 120.h,
              text: "lbl_cancel".tr,
              buttonStyle: CustomButtonStyles.fillBlackGray.copyWith(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.h)))),
              buttonTextStyle: CustomTextStyles.bodyLargeErrorContainer,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CustomElevatedButton(
              height: 40.h,
              width: 120.h,
              text: "lbl_create".tr,
              buttonStyle: CustomButtonStyles.fillPrimaryRadius12.copyWith(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.h)))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<HomeBloc>().add(
                        CreateGroupEvent(
                          onCreateGroupSuccess: () {
                            _onCreateGroupSuccess(context);
                          },
                          onCreateGroupError: () {
                            _onCreateGroupError(context);
                          },
                          name: _nameController.text,
                          description: _descriptionController.text,
                          background: _selectedImage,
                        ),
                      );
                }
              },
            )
          ],
        )
      ],
    );
  }

  void _onCreateGroupSuccess(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: 'Create group succeed',
      ),
    );
    NavigatorService.pushNamed(
      AppRoutes.homeScreen,
    );
  }

  void _onCreateGroupError(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'Create group failed',
      ),
    );
    NavigatorService.pushNamed(
      AppRoutes.homeScreen,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../../core/app_export.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../models/my_group_list_item_model.dart';

// ignore_for_file: must_be_immutable
class MyGroupListItemWidget extends StatelessWidget {
  MyGroupListItemWidget(this.myGroupListItemModelObj,
      {super.key, this.callDetail, this.onDelete});

  MyGroupListItemModel myGroupListItemModelObj;
  VoidCallback? callDetail;
  Function(String)? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callDetail?.call();
      },
      child: Container(
        decoration: BoxDecoration(
            color: appTheme.whiteA700.withOpacity(1),
            borderRadius: BorderRadiusStyle.roundedBorder20,
            border: Border.all(
              color: appTheme.blueGray10002,
              width: 0.5.h,
            ),
            boxShadow: [
              BoxShadow(
                color: appTheme.black900.withOpacity(0.05),
                spreadRadius: 0.h,
                blurRadius: 10.h,
                offset: const Offset(0, 4),
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 118.h,
                width: 118.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImageView(
                      imagePath: myGroupListItemModelObj.displayImage,
                      height: 130.h,
                      width: double.maxFinite,
                      radius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                        right: Radius.zero,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.h),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          myGroupListItemModelObj.displayNameOfGroup ?? "",
                          style: theme.textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _buildStatusButton()
                    ],
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      myGroupListItemModelObj.displayDate ?? "",
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: double.maxFinite,
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(right: 20.h),
                    child: PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        color: appTheme.gray500,
                      ),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Delete',
                              style: TextStyle(color: appTheme.red900)),
                        ),
                      ],
                      onSelected: (String value) {
                        if (value == 'delete') {
                          _showDeleteConfirmationDialog(context);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton() {
    return CustomElevatedButton(
      height: 24.h,
      width: 55.h,
      text: myGroupListItemModelObj.role ?? "HOST",
      margin: EdgeInsets.only(left: 8.h),
      buttonStyle: CustomButtonStyles.fillErrorRadius5,
      buttonTextStyle: CustomTextStyles.labelSmallRed700,
      alignment: Alignment.center,
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Delete Confirmation',
      desc: 'Are you sure you want to delete this item?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        if (onDelete != null && myGroupListItemModelObj.id != null) {
          onDelete!(myGroupListItemModelObj.id!);
        }
      },
      btnCancelText: 'Cancel',
      btnCancelColor: appTheme.gray500,
      btnOkText: 'Delete',
      btnOkColor: appTheme.red900,
      buttonsTextStyle: const TextStyle(color: Colors.white),
    ).show();
  }
}

import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/recent_activities_grid_item_model.dart';

// ignore_for_file: must_be_immutable
class RecentActivitiesGridItemWidget extends StatelessWidget {
  RecentActivitiesGridItemWidget(this.recentActivitiesGridItemModelObj,
      {this.callDetail, super.key});
  RecentActivitiesGridItemModel recentActivitiesGridItemModelObj;
  VoidCallback? callDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
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
              spreadRadius: 2.h,
              blurRadius: 10.h,
              offset: const Offset(
                0,
                4,
              ),
            )
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: recentActivitiesGridItemModelObj.imagePath,
            height: 102.h,
            width: double.maxFinite,
            radius: BorderRadius.vertical(
              top: Radius.circular(10.h),
            ),
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 6.h),
              child: Text(
                recentActivitiesGridItemModelObj.title!,
                style: CustomTextStyles.bodyMediumBlack900_1
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  recentActivitiesGridItemModelObj.date!,
                  style: CustomTextStyles.bodySmallGray90001,
                ),
                const Spacer(),
                Hero(
                  tag:
                      'library_cover_image_${recentActivitiesGridItemModelObj.id}',
                  child: Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20.h),
                      onTap: () {
                        callDetail?.call();
                      },
                      highlightColor: appTheme.deppPurplePrimary,
                      splashColor: appTheme.deppPurplePrimary,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.h, vertical: 4.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.h),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: appTheme.blueGray300,
                              size: 15.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2.h),
                              child: Text(
                                'Edit',
                                style: CustomTextStyles.bodySmallGray90001,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }
}

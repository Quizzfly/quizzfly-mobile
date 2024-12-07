import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/app_export.dart';
import '../../routes/navigation_args.dart';
import '../my_group_screen/bloc/my_group_bloc.dart';
import '../my_group_screen/models/my_group_model.dart';
import '../my_group_screen/models/my_group_list_item_model.dart';
import '../my_group_screen/widgets/my_group_list_item_widget.dart';

class MyGroupScreen extends StatelessWidget {
  const MyGroupScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider<MyGroupBloc>(
      create: (context) => MyGroupBloc(MyGroupState(
        myGroupModelObj: MyGroupModel(),
      ))
        ..add(MyGroupInitialEvent()),
      child: const MyGroupScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 18.h),
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              BlocSelector<MyGroupBloc, MyGroupState, MyGroupModel?>(
                selector: (state) => state.myGroupModelObj,
                builder: (context, myGroupModelObj) {
                  return Text(
                    "${myGroupModelObj?.groupCount ?? 0} Groups",
                    style: CustomTextStyles.titleMediumRobotoBlack900,
                  );
                },
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: _buildMyGroupList(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMyGroupList(BuildContext context) {
    return BlocSelector<MyGroupBloc, MyGroupState, MyGroupModel?>(
      selector: (state) => state.myGroupModelObj,
      builder: (context, myGroupModelObj) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 15.h,
            );
          },
          itemCount: myGroupModelObj?.myGroupListItemList.length ?? 0,
          itemBuilder: (context, index) {
            MyGroupListItemModel model =
                myGroupModelObj?.myGroupListItemList[index] ??
                    const MyGroupListItemModel();
            return MyGroupListItemWidget(
              model,
              callDetail: () {
                callDetail(context, index);
              },
              onDelete: (String id) {
                callAPIDelete(context, id);
              },
            );
          },
        );
      },
    );
  }

  /// Navigates to the quizzflyDetailScreen when the action is triggered.
  callDetail(BuildContext context, int index) async {
    final refreshRequired = await NavigatorService.pushNamed(
      AppRoutes.quizzflyDetailScreen,
      arguments: {
        NavigationArgs.id:
            context.read<MyGroupBloc>().getMyGroupResp.data?[index].group?.id,
      },
    );

    // If returned value is true, refresh the myGroup data
    if (refreshRequired == true) {
      context.read<MyGroupBloc>().add(
            CreateGetMyGroupEvent(
              onGetMyGroupSuccess: () {},
              onGetMyGroupError: () {},
            ),
          );
    }
  }

  callAPIDelete(BuildContext context, String id) {
    context.read<MyGroupBloc>().add(
          DeleteMyGroupEvent(
            id: id,
            onDeleteMyGroupEventSuccess: () {
              _onDeleteMyGroupApiEventSuccess(context);
            },
            onDeleteMyGroupEventError: () {
              _onDeleteMyGroupApiEventError(context);
            },
          ),
        );
  }

  void _onDeleteMyGroupApiEventSuccess(BuildContext context) {
    Fluttertoast.showToast(msg: "Delete succeed");
    // Refresh the list after successful deletion
    context.read<MyGroupBloc>().add(CreateGetMyGroupEvent(
      onGetMyGroupSuccess: () {
        Fluttertoast.showToast(
          msg: "Delete succeed",
        );
      },
    ));
  }

  void _onDeleteMyGroupApiEventError(BuildContext context) {
    Fluttertoast.showToast(msg: "Delete failed");
  }
}

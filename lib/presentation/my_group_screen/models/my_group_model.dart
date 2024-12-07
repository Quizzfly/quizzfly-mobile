import 'package:equatable/equatable.dart';
import 'my_group_list_item_model.dart';

/// This class defines the variables used in the [myGroup_screen],
/// and is typically used to hold data that is passed between different parts of the application.
// ignore_for_file: must_be_immutable
class MyGroupModel extends Equatable {
  MyGroupModel({this.myGroupListItemList = const []});
  List<MyGroupListItemModel> myGroupListItemList;
  int get groupCount {
    return myGroupListItemList.length;
  }

  MyGroupModel copyWith({List<MyGroupListItemModel>? myGroupListItemList}) {
    return MyGroupModel(
      myGroupListItemList: myGroupListItemList ?? this.myGroupListItemList,
    );
  }

  @override
  List<Object?> get props => [myGroupListItemList];
}

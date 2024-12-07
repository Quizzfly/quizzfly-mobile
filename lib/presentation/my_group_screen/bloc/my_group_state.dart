part of 'my_group_bloc.dart';

/// Represents the state of MyGroup in the application.
// ignore_for_file: must_be_immutable
class MyGroupState extends Equatable {
  MyGroupState({this.myGroupModelObj});
  MyGroupModel? myGroupModelObj;
  @override
  List<Object?> get props => [myGroupModelObj];
  MyGroupState copyWith({MyGroupModel? myGroupModelObj}) {
    return MyGroupState(
      myGroupModelObj: myGroupModelObj ?? this.myGroupModelObj,
    );
  }
}

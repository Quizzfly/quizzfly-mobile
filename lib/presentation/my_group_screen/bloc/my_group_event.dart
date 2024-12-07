part of 'my_group_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// MyGroup widget.
///
/// Events must be immutable and implement the [Equatable] interface.
abstract class MyGroupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the MyGroup widget is first created.
class MyGroupInitialEvent extends MyGroupEvent {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched to fetch library data
// ignore: must_be_immutable
class CreateGetMyGroupEvent extends MyGroupEvent {
  CreateGetMyGroupEvent({
    this.id,
    this.onGetMyGroupSuccess,
    this.onGetMyGroupError,
  });

  Function? onGetMyGroupSuccess;
  Function? onGetMyGroupError;
  String? id;
  @override
  List<Object?> get props => [onGetMyGroupSuccess, onGetMyGroupError, id];
}

// ignore: must_be_immutable
class DeleteMyGroupEvent extends MyGroupEvent {
  DeleteMyGroupEvent({
    this.id,
    this.onDeleteMyGroupEventSuccess,
    this.onDeleteMyGroupEventError,
  });

  Function? onDeleteMyGroupEventSuccess;
  Function? onDeleteMyGroupEventError;
  String? id;
  @override
  List<Object?> get props =>
      [onDeleteMyGroupEventSuccess, onDeleteMyGroupEventError, id];
}

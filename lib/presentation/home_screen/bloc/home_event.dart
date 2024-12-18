part of 'home_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Home widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the Home widget is first created.
class HomeInitialEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class CreateGetRecentActivitiesEvent extends HomeEvent {
  final Function? onGetRecentActivitiesSuccess;
  final Function? onGetRecentActivitiesError;
  final String? id;
  CreateGetRecentActivitiesEvent({
    this.onGetRecentActivitiesSuccess,
    this.onGetRecentActivitiesError,
    this.id,
  });

  @override
  List<Object?> get props =>
      [onGetRecentActivitiesSuccess, onGetRecentActivitiesError, id];
}

part of 'login_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Login widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the Login widget is first created.
class LoginInitialEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

///Event that is dispatched when the user calls the {{baseUrl}}/api/v1/auth/login API.
// ignore_for_file: must_be_immutable
class CreateLoginEvent extends LoginEvent {
  CreateLoginEvent(
      {this.onCreateLoginEventSuccess, this.onCreateLoginEventError});
  Function? onCreateLoginEventSuccess;
  Function? onCreateLoginEventError;
  @override
  List<Object?> get props =>
      [onCreateLoginEventSuccess, onCreateLoginEventError];
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/waiting_room_model.dart';
part 'waiting_room_event.dart';
part 'waiting_room_state.dart';

class WaitingRoomBloc extends Bloc<WaitingRoomEvent, WaitingRoomState> {
  final SocketService _socketService = SocketService();
  late StreamSubscription _quizStartedSubscription;
  WaitingRoomBloc(super.initialState) {
    on<WaitingRoomInitialEvent>(_onInitialize);
    on<QuizStartedWaitingEvent>(_onQuizStarted);
    on<SocketErrorEvent>(_onSocketError);
    on<PlayerKickedEvent>(_onPlayerKicked);

    _quizStartedSubscription = _socketService.onQuizStarted.listen(
      (_) => add(QuizStartedWaitingEvent()),
      onError: (error) => add(SocketErrorEvent(error.toString())),
    );
    _initializeKickPlayerSubscription();
  }

  _onInitialize(
    WaitingRoomInitialEvent event,
    Emitter<WaitingRoomState> emit,
  ) async {
    emit(state.copyWith(
      nameController: TextEditingController(text: PrefUtils().getNickname()),
      connectionStatus: ConnectionStatus.connecting,
    ));
  }

  void _onQuizStarted(
    QuizStartedWaitingEvent event,
    Emitter<WaitingRoomState> emit,
  ) {
    emit(state.copyWith(
      connectionStatus: ConnectionStatus.quizStarted,
    ));
  }

  void _onSocketError(
    SocketErrorEvent event,
    Emitter<WaitingRoomState> emit,
  ) {
    emit(state.copyWith(
      error: event.error,
      connectionStatus: ConnectionStatus.error,
    ));
  }

  void _initializeKickPlayerSubscription() {
    _socketService.socket.on('playerKicked', (data) {
      add(PlayerKickedEvent(data['reason'].toString()));
    });
  }

  void _onPlayerKicked(
    PlayerKickedEvent event,
    Emitter<WaitingRoomState> emit,
  ) {
    emit(state.copyWith(
      error: event.reason,
      connectionStatus: ConnectionStatus.error,
    ));
    NavigatorService.pushNamedAndRemoveUntil(
      AppRoutes.loginScreen,
      routePredicate: false,
    );
  }

  @override
  Future<void> close() async {
    await _quizStartedSubscription.cancel();
    return super.close();
  }
}

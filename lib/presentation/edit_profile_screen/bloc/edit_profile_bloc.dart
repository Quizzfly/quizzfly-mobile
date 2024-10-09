import 'dart:async';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../../data/models/my_user/get_my_user_resp.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../../data/repository/repository.dart';
import '../models/edit_profile_model.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

/// A bloc that manages the state of a EditProfile according to the event that is dispatched to it.
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(EditProfileState initialState) : super(initialState) {
    on<EditProfileInitialEvent>(_onInitialize);
    on<TextFieldChangedEvent>(_onTextFieldChanged);
    on<CreateLGetUserEvent>(_callGetMyUser);
  }

  final _repository = Repository();
  var getMyUserResp = GetMyUserResp();
  List<SelectionPopupModel> fillDropdownItemList() {
    return [
      SelectionPopupModel(
        id: 1,
        title: "Item One",
        isSelected: true,
      ),
      SelectionPopupModel(
        id: 2,
        title: "Item Two",
      ),
      SelectionPopupModel(
        id: 3,
        title: "Item Three",
      )
    ];
  }

  List<SelectionPopupModel> fillDropdownItemList1() {
    return [
      SelectionPopupModel(
        id: 1,
        title: "Item One",
        isSelected: true,
      ),
      SelectionPopupModel(
        id: 2,
        title: "Item Two",
      ),
      SelectionPopupModel(
        id: 3,
        title: "Item Three",
      )
    ];
  }

  List<SelectionPopupModel> fillDropdownItemList2() {
    return [
      SelectionPopupModel(
        id: 1,
        title: "Item One",
        isSelected: true,
      ),
      SelectionPopupModel(
        id: 2,
        title: "Item Two",
      ),
      SelectionPopupModel(
        id: 3,
        title: "Item Three",
      )
    ];
  }

  // In your EditProfileBloc

  void _onInitialize(
    EditProfileInitialEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      add(CreateLGetUserEvent(onCreateLoginEventSuccess: () {
        print('User data fetched successfully');
      }));
      // Update state with the fetched data
      emit(state.copyWith(
        usernameInputController: TextEditingController(),
        nameInputController: TextEditingController(),
        emailInputController: TextEditingController(),
      ));
    } catch (e) {
      print('Error initializing profile data: $e');
    }
  }

  _onTextFieldChanged(
    TextFieldChangedEvent event,
    Emitter<EditProfileState> emit,
  ) {
    // Enable save button if all fields are filled
    bool isButtonEnabled = event.username.isNotEmpty ||
        event.name.isNotEmpty ||
        event.email.isNotEmpty;

    emit(state.copyWith(isSaveButtonEnabled: isButtonEnabled));
  }

  FutureOr<void> _callGetMyUser(
    CreateLGetUserEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    String accessToken = await PrefUtils().getAccessToken();
    // Retrieve access token from SharedPreferences
    await _repository.getMyUser(
      headers: {'Authorization': 'Bearer $accessToken'},
    ).then((value) async {
      getMyUserResp = value;
      _onGetMyUserSuccess(value, emit);
      event.onCreateLoginEventSuccess?.call();
    }).onError((error, stackTrace) {
      _onGetMyUserError();
      event.onCreateLoginEventError?.call();
    });
  }

  void _onGetMyUserSuccess(
    GetMyUserResp resp,
    Emitter<EditProfileState> emit,
  ) {
    emit(state.copyWith(
      usernameInputController:
          TextEditingController(text: resp.data?.userInfo?.username ?? ''),
      nameInputController:
          TextEditingController(text: resp.data?.userInfo?.name ?? ''),
      emailInputController: TextEditingController(text: resp.data?.email ?? ''),
    ));
  }

  void _onGetMyUserError() {}
}

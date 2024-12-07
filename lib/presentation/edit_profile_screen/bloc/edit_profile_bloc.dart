import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../../data/models/my_user/get_my_user_resp.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../../data/models/update_profile/patch_update_profile_req.dart';
import '../../../data/models/upload_file/post_upload_file.dart';
import '../../../data/repository/repository.dart';
import '../models/edit_profile_model.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

/// A bloc that manages the state of a EditProfile according to the event that is dispatched to it.
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(super.initialState) {
    on<EditProfileInitialEvent>(_onInitialize);
    on<TextFieldChangedEvent>(_onTextFieldChanged);
    on<CreateLGetUserEvent>(_callGetMyUser);
    on<ImagePickedEvent>(_onImagePicked);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  final _repository = Repository();
  var getMyUserResp = GetMyUserResp();
  List<SelectionPopupModel> fillDropdownItemList() {
    return [
      SelectionPopupModel(
        id: 1,
        title: "English",
        isSelected: true,
      ),
      SelectionPopupModel(
        id: 2,
        title: "Tiếng Việt",
      ),
    ];
  }
  // In your EditProfileBloc

  void _onInitialize(
    EditProfileInitialEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      add(CreateLGetUserEvent(onCreateLoginEventSuccess: () {}));
      // Update state with the fetched data
      emit(state.copyWith(
        usernameInputController: TextEditingController(),
        nameInputController: TextEditingController(),
        emailInputController: TextEditingController(),
      ));
      emit(state.copyWith(
          editProfileModelObj: state.editProfileModelObj?.copyWith(
        dropdownItemList: fillDropdownItemList(),
      )));
      // ignore: empty_catches
    } catch (e) {}
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
    String accessToken = PrefUtils().getAccessToken();
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
      imageFile: resp.data?.userInfo?.avatar,
    ));
    PrefUtils().setUsername(resp.data?.userInfo?.username ?? '');
    PrefUtils().setName(resp.data?.userInfo?.name ?? '');
    PrefUtils().setAvatar(resp.data?.userInfo?.avatar ?? '');
  }

  void _onGetMyUserError() {}

  void _onImagePicked(
    ImagePickedEvent event,
    Emitter<EditProfileState> emit,
  ) {
    emit(state.copyWith(
      imageFile: event.imageFile,
      isSaveButtonEnabled: true,
    ));
  }

  FutureOr<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    String accessToken = PrefUtils().getAccessToken();
    String? avatarUrl;

    if (state.imageFile != null && state.imageFile is File) {
      UploadFileResp uploadResp = await _repository.uploadFile(
        file: state.imageFile,
        headers: {},
      );
      avatarUrl = uploadResp.data?.url;
    }

    final req = PatchUpdateProfileReq(
      name: state.nameInputController?.text,
      avatar: avatarUrl ?? state.imageFile,
    );
    await _repository.updateProfile(
      requestData: req,
      headers: {'Authorization': 'Bearer $accessToken'},
    ).then((value) async {
      getMyUserResp = value;
      _onGetMyUserSuccess(value, emit);
      event.onSuccess?.call();
    }).onError((error, stackTrace) {
      _onGetMyUserError();
      event.onError?.call();
    });
  }
}

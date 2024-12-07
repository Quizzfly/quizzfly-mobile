import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/presentation/my_group_screen/models/my_group_list_item_model.dart';
import '../../../data/models/my_group/get_my_group_resp.dart';
import '../../../core/app_export.dart';
import '../../../data/repository/repository.dart';
import '../models/my_group_model.dart';
part 'my_group_event.dart';
part 'my_group_state.dart';

/// A bloc that manages the state of a MyGroup according to the event that is dispatched to it.
class MyGroupBloc extends Bloc<MyGroupEvent, MyGroupState> {
  final _repository = Repository();
  var getMyGroupResp = GetMyGroupsResp();

  MyGroupBloc(super.initialState) {
    on<MyGroupInitialEvent>(_onInitialize);
    on<CreateGetMyGroupEvent>(_callGetMyGroup);
    on<DeleteMyGroupEvent>(_callDeleteMyGroupApi);
  }

  Future<void> _onInitialize(
    MyGroupInitialEvent event,
    Emitter<MyGroupState> emit,
  ) async {
    try {
      add(CreateGetMyGroupEvent(
        onGetMyGroupSuccess: () {},
      ));

      emit(state.copyWith(
        myGroupModelObj: state.myGroupModelObj?.copyWith(
          myGroupListItemList: [],
        ),
      ));
    } catch (e) {
      print('Error initializing myGroup data: $e');
    }
  }

  FutureOr<void> _callGetMyGroup(
    CreateGetMyGroupEvent event,
    Emitter<MyGroupState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();

      await _repository.getMyGroup(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ).then((value) async {
        getMyGroupResp = value;
        _onGetMyGroupSuccess(value, emit);
        event.onGetMyGroupSuccess?.call();
      }).onError((error, stackTrace) {
        _onGetMyGroupError();
        event.onGetMyGroupError?.call();
      });
    } catch (e) {
      print('Error loading myGroup: $e');
      _onGetMyGroupError();
      event.onGetMyGroupError?.call();
    }
  }

  void _onGetMyGroupSuccess(
    GetMyGroupsResp resp,
    Emitter<MyGroupState> emit,
  ) {
    final myGroupItems = resp.data?.map((item) {
          final formattedDate = _formatDate(item.group?.createdAt ?? "");
          return MyGroupListItemModel.fromMyGroupData(
            json: item.toJson(),
            formattedDate: formattedDate,
          );
        }).toList() ??
        [];

    emit(state.copyWith(
      myGroupModelObj: state.myGroupModelObj?.copyWith(
        myGroupListItemList: myGroupItems,
      ),
    ));
  }

  void _onGetMyGroupError() {
    // Handle error state here
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return "Today";
      } else if (difference.inDays == 1) {
        return "Yesterday";
      } else if (difference.inDays < 7) {
        return "${difference.inDays} days ago";
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return "$weeks ${weeks == 1 ? 'week' : 'weeks'} ago";
      } else {
        final months = (difference.inDays / 30).floor();
        return "$months ${months == 1 ? 'month' : 'months'} ago";
      }
    } catch (e) {
      return dateStr;
    }
  }

  FutureOr<void> _callDeleteMyGroupApi(
    DeleteMyGroupEvent event,
    Emitter<MyGroupState> emit,
  ) async {
    String? accessToken = PrefUtils().getAccessToken();

    try {
      bool success = await _repository.deleteMyGroup(
          headers: {'Authorization': 'Bearer $accessToken '}, id: event.id);
      if (success) {
        event.onDeleteMyGroupEventSuccess?.call();
      } else {
        event.onDeleteMyGroupEventError?.call();
      }
    } catch (error) {
      event.onDeleteMyGroupEventError?.call();
    }
  }
}

import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import '../../../data/models/create_group/post_create_group_req.dart';
import '../../../core/app_export.dart';
import '../../../data/models/library_quizzfly/get_library_quizzfly_resp.dart';
import '../../../data/models/upload_file/post_upload_file.dart';
import '../../../data/repository/repository.dart';
import '../models/grid_label_item_model.dart';
import '../models/home_initial_model.dart';
import '../models/home_model.dart';
import '../models/recent_activities_grid_item_model.dart';
part 'home_event.dart';
part 'home_state.dart';

/// A bloc that manages the state of a Home according to the event that is dispatched to it.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _repository = Repository();
  var getRecentActivitiesResp = GetLibraryQuizzflyResp();
  final String? accessToken = PrefUtils().getAccessToken();

  HomeBloc(super.initialState) {
    on<HomeInitialEvent>(_onInitialize);
    on<CreateGetRecentActivitiesEvent>(_callGetRecentActivities);
    on<CreateGroupEvent>(_callCreateGroup);
  }
  _onInitialize(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    add(CreateGetRecentActivitiesEvent(
      onGetRecentActivitiesSuccess: () {},
    ));
    emit(
      state.copyWith(
        homeInitialModelObj: state.homeInitialModelObj?.copyWith(
          gridLabelItemList: fillGridLabelItemList(),
          recentActivitiesGridItemList: [],
        ),
      ),
    );
  }

  List<GridLabelItemModel> fillGridLabelItemList() {
    return [
      GridLabelItemModel(image: ImageConstant.imgCreate, label: "Your group"),
      GridLabelItemModel(image: ImageConstant.imgCreate, label: "Your group"),
      GridLabelItemModel(image: ImageConstant.imgGroup, label: "Your group"),
      GridLabelItemModel()
    ];
  }

  FutureOr<void> _callGetRecentActivities(
    CreateGetRecentActivitiesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _repository.getLibraryQuizzfly(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ).then((value) async {
        getRecentActivitiesResp = value;
        _onGetRecentActivitiesSuccess(value, emit);
        event.onGetRecentActivitiesSuccess?.call();
      }).onError((error, stackTrace) {
        _onGetRecentActivitiesError();
        event.onGetRecentActivitiesError?.call();
      });
    } catch (e) {
      print('Error loading recent activities: $e');
      _onGetRecentActivitiesError();
      event.onGetRecentActivitiesError?.call();
    }
  }

  void _onGetRecentActivitiesSuccess(
    GetLibraryQuizzflyResp resp,
    Emitter<HomeState> emit,
  ) {
    final recentActivitiesItems = resp.data?.map((item) {
          final formattedDate = _formatDate(item.createdAt ?? "");
          return RecentActivitiesGridItemModel(
            title: item.title ?? "Untitled",
            date: formattedDate,
            imagePath: item.coverImage ?? ImageConstant.imgNotFound,
            id: item.id ?? "",
          );
        }).toList() ??
        [];

    emit(state.copyWith(
      homeInitialModelObj: state.homeInitialModelObj?.copyWith(
        recentActivitiesGridItemList: recentActivitiesItems,
      ),
    ));
  }

  void _onGetRecentActivitiesError() {
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

  FutureOr<void> _callCreateGroup(
    CreateGroupEvent event,
    Emitter<HomeState> emit,
  ) async {
    String? imageUrl;

    if (event.background != null && event.background is File) {
      UploadFileResp uploadResp = await _repository.uploadFile(
        file: event.background,
        headers: {},
      );
      imageUrl = uploadResp.data?.url;
    }
    var postCreateGroupReq = PostCreateGroupReq(
      name: event.name ?? '',
      description: event.description ?? '',
      background: imageUrl ?? '',
    );
    try {
      await _repository.createGroup(headers: {
        'Authorization': 'Bearer $accessToken',
      }, requestData: postCreateGroupReq.toJson()).then((value) async {
        event.onCreateGroupSuccess?.call();
      }).onError((error, stackTrace) {
        event.onCreateGroupError?.call();
      });
    } catch (e) {
      print('Error loading recent activities: $e');
      event.onCreateGroupError?.call();
    }
  }
}

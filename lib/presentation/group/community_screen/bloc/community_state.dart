part of 'community_bloc.dart';

/// Represents the state of Community in the application.
// ignore_for_file: must_be_immutable
class CommunityState extends Equatable {
  const CommunityState(
      {this.commentInputFieldController,
      this.postInputFieldController,
      this.communityActivityTabModelObj,
      this.communityModelObj,
      this.id});
  final TextEditingController? commentInputFieldController;
  final TextEditingController? postInputFieldController;
  final CommunityModel? communityModelObj;
  final CommunityActivityTabModel? communityActivityTabModelObj;
  final String? id;

  @override
  List<Object?> get props => [
        commentInputFieldController,
        postInputFieldController,
        communityActivityTabModelObj,
        communityModelObj,
        id
      ];
  CommunityState copyWith({
    TextEditingController? commentInputFieldController,
    TextEditingController? postInputFieldController,
    CommunityActivityTabModel? communityActivityTabModelObj,
    CommunityModel? communityModelObj,
    String? id,
  }) {
    return CommunityState(
      commentInputFieldController:
          commentInputFieldController ?? this.commentInputFieldController,
      postInputFieldController:
          postInputFieldController ?? this.postInputFieldController,
      communityActivityTabModelObj:
          communityActivityTabModelObj ?? this.communityActivityTabModelObj,
      communityModelObj: communityModelObj ?? this.communityModelObj,
      id: id ?? this.id,
    );
  }
}
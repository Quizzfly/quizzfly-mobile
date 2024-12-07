import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';

/// This class is used in the [librarylist_item_widget] screen.
class LibraryListItemModel extends Equatable {
  final String? id;
  final String? title;
  final String? coverImage;
  final String? quizzflyStatus;
  final String? createdAt;
  final bool? isPublic;

  // UI-specific fields
  final String?
      displayImage; // The actual image to display (could be coverImage or default)
  final String?
      displayTitle; // The title to display (could be title or "Untitled")
  final String? displayDate; // Formatted date string
  final String? publicIcon; // Icon for public/private status
  final String? publicText; // Text for public/private status

  const LibraryListItemModel({
    this.id,
    this.title,
    this.coverImage,
    this.quizzflyStatus,
    this.createdAt,
    this.isPublic,
    this.displayImage,
    this.displayTitle,
    this.displayDate,
    this.publicIcon,
    this.publicText,
  });

  LibraryListItemModel copyWith({
    String? id,
    String? title,
    String? coverImage,
    String? quizzflyStatus,
    String? createdAt,
    bool? isPublic,
    String? userId,
    String? username,
    String? avatar,
    String? displayImage,
    String? displayTitle,
    String? displayDate,
    String? publicIcon,
    String? publicText,
  }) {
    return LibraryListItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      coverImage: coverImage ?? this.coverImage,
      quizzflyStatus: quizzflyStatus ?? this.quizzflyStatus,
      createdAt: createdAt ?? this.createdAt,
      isPublic: isPublic ?? this.isPublic,
      displayImage: displayImage ?? this.displayImage,
      displayTitle: displayTitle ?? this.displayTitle,
      displayDate: displayDate ?? this.displayDate,
      publicIcon: publicIcon ?? this.publicIcon,
      publicText: publicText ?? this.publicText,
    );
  }

  factory LibraryListItemModel.fromQuizzflyData({
    required Map<String, dynamic> json,
    required String formattedDate,
  }) {
    final isPublic = json['is_public'] as bool? ?? false;

    return LibraryListItemModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      coverImage: json['cover_image'] as String?,
      quizzflyStatus: json['quizzfly_status'] as String?,
      createdAt: json['created_at'] as String?,
      isPublic: isPublic,
      displayImage: json['cover_image'] ?? ImageConstant.imgNotFound,
      displayTitle: json['title'] ?? "Untitled",
      displayDate: formattedDate,
      publicIcon:
          isPublic ? ImageConstant.imageUserGroup : ImageConstant.imageUser,
      publicText: isPublic ? "Public" : "Only me",
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        coverImage,
        quizzflyStatus,
        createdAt,
        isPublic,
        displayImage,
        displayTitle,
        displayDate,
        publicIcon,
        publicText,
      ];
}

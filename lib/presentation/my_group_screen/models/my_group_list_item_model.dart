import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';

class MyGroupListItemModel extends Equatable {
  final String? id;
  final String? nameOfGroup;
  final String? coverImage;
  final String? createdAt;
  final String? displayImage;
  final String? displayNameOfGroup;
  final String? displayDate;
  final String? role;

  const MyGroupListItemModel({
    this.id,
    this.nameOfGroup,
    this.coverImage,
    this.createdAt,
    this.displayImage,
    this.displayNameOfGroup,
    this.displayDate,
    this.role,
  });

  MyGroupListItemModel copyWith({
    String? id,
    String? nameOfGroup,
    String? coverImage,
    String? createdAt,
    String? username,
    String? avatar,
    String? displayImage,
    String? displayNameOfGroup,
    String? displayDate,
    String? role,
  }) {
    return MyGroupListItemModel(
      id: id ?? this.id,
      nameOfGroup: nameOfGroup ?? this.nameOfGroup,
      coverImage: coverImage ?? this.coverImage,
      createdAt: createdAt ?? this.createdAt,
      displayImage: displayImage ?? this.displayImage,
      displayNameOfGroup: displayNameOfGroup ?? this.displayNameOfGroup,
      displayDate: displayDate ?? this.displayDate,
      role: role ?? this.role,
    );
  }

  factory MyGroupListItemModel.fromMyGroupData({
    required Map<String, dynamic> json,
    required String formattedDate,
  }) {
    return MyGroupListItemModel(
      id: json['group']?['id'] as String?,
      nameOfGroup: json['group']?['name'] as String?,
      coverImage: json['group']?['background'] as String?,
      createdAt: json['group']?['created_at'] as String?,
      displayImage: (json['group']['background'] ?? '') == ''
          ? ImageConstant.imgNotFound
          : json['group']['background'],
      displayNameOfGroup: json['group']['name'] ?? "Untitled",
      displayDate: formattedDate,
      role: json['role'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        nameOfGroup,
        coverImage,
        createdAt,
        displayImage,
        displayNameOfGroup,
        displayDate,
        role,
      ];
}

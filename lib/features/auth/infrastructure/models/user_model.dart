import 'package:clean_architecture/features/auth/domain/entities/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@CopyWith()
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.token,
    required super.uuid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

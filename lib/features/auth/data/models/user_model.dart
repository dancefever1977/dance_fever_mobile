import 'package:dance_fever/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.uid, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {'uid': uid, 'email': email, 'name': name};
}

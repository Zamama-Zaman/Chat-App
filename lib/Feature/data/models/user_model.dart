import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/Feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? name,
    String? email,
    String? uid,
    String? profileUrl,
  }) : super(
          name: name,
          email: email,
          uid: uid,
          profileUrl: profileUrl,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        profileUrl: json['profileUrl'],
        email: json['email'],
        uid: json['uid']);
  }
  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      name: documentSnapshot.get('name'),
      uid: documentSnapshot.get('uid'),
      email: documentSnapshot.get('email'),
      profileUrl: documentSnapshot.get('profileUrl'),
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "uid": uid,
      "email": email,
      "profileUrl": profileUrl,
    };
  }
}

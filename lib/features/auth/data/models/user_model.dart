// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final String email;
  final String phone;
  final String role;
  final String? profileUrl;
  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.email,
    required this.phone,
    this.profileUrl,
    required this.role,
  });

  UserModel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    DateTime? createdAt,
    String? email,
    String? phone,
    String? profileUrl,
    String? role,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileUrl: profileUrl ?? this.profileUrl,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': Timestamp.fromDate(createdAt),
      'email': email,
      'phone': phone,
      'profileUrl': profileUrl,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      email: map['email'] as String,
      phone: map['phone'] as String,
      profileUrl:
          map['profileUrl'] != null ? map['profileUrl'] as String : null,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, firstName: $firstName, lastName: $lastName, createdAt: $createdAt, email: $email, phone: $phone, profileUrl: $profileUrl, role: $role)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.createdAt == createdAt &&
        other.email == email &&
        other.phone == phone &&
        other.profileUrl == profileUrl &&
        other.role == role;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        createdAt.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        profileUrl.hashCode ^
        role.hashCode;
  }
}

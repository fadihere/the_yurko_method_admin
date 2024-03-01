// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final String email;
  final String phone;
  final String role;
  final String? profileUrl;
  final String referalCode;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.email,
    required this.phone,
    required this.role,
    this.profileUrl,
    required this.referalCode,
  });

  UserModel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    DateTime? createdAt,
    String? email,
    String? phone,
    String? role,
    String? profileUrl,
    String? referalCode,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profileUrl: profileUrl ?? this.profileUrl,
      referalCode: referalCode ?? this.referalCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'email': email,
      'phone': phone,
      'role': role,
      'profileUrl': profileUrl,
      'referalCode': referalCode,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      email: map['email'] as String,
      phone: map['phone'] as String,
      role: map['role'] as String,
      profileUrl:
          map['profileUrl'] != null ? map['profileUrl'] as String : null,
      referalCode: map['referalCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, firstName: $firstName, lastName: $lastName, createdAt: $createdAt, email: $email, phone: $phone, role: $role, profileUrl: $profileUrl, referalCode: $referalCode)';
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
        other.role == role &&
        other.profileUrl == profileUrl &&
        other.referalCode == referalCode;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        createdAt.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        role.hashCode ^
        profileUrl.hashCode ^
        referalCode.hashCode;
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

// ignore: deprecated_member_use
@JsonSerializable(nullable: false)
class AppUser {
  String? id;
  String? firstName;
  String? lastName;
  String? displayName;
  String? email;
  bool? isEmailVerified = false;
  String? relation;
  String? phoneNumber;
  String? address;
  String? country;
  String? profileImageUrl;
  bool? isPremium = false;
  int? lastNotificationReadTime = 0;
  Map<String, dynamic>? package;

  AppUser({
    this.firstName,
    this.displayName,
    this.lastName,
    this.profileImageUrl,
    this.country,
    this.isEmailVerified,
    this.email,
    this.relation,
    this.phoneNumber,
    this.lastNotificationReadTime,
    this.address,
    this.id,
    this.isPremium,
    this.package,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}

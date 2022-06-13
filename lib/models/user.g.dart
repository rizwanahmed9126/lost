// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return AppUser(
    firstName: json['firstName'] as String?,
    displayName: json['displayName'] as String?,
    lastName: json['lastName'] as String?,
    profileImageUrl: json['profileImageUrl'] as String?,
    country: json['country'] as String?,
    isEmailVerified: json['isEmailVerified'] as bool?,
    email: json['email'] as String?,
    relation: json['relation'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    lastNotificationReadTime: json['lastNotificationReadTime'] as int?,
    address: json['address'] as String?,
    id: json['id'] as String?,
    isPremium: json['isPremium'] as bool?,
    package: json['package'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'displayName': instance.displayName,
      'email': instance.email,
      'isEmailVerified': instance.isEmailVerified,
      'relation': instance.relation,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'country': instance.country,
      'profileImageUrl': instance.profileImageUrl,
      'isPremium': instance.isPremium,
      'lastNotificationReadTime': instance.lastNotificationReadTime,
      'package': instance.package,
    };

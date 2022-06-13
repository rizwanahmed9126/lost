// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddContact _$AddContactFromJson(Map<String, dynamic> json) {
  return AddContact(
    name: json['name'] as String?,
    id: json['id'] as String?,
    relation: json['relation'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    address: json['address'] as String?,
  );
}

Map<String, dynamic> _$AddContactToJson(AddContact instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'relation': instance.relation,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
    };

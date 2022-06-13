// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactInfo _$ContactInfoFromJson(Map<String, dynamic> json) {
  return ContactInfo(
    id: json['id'] as String?,
    contactName: json['contactName'] as String?,
    relation: json['relation'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    address: json['address'] as String?,
  );
}

Map<String, dynamic> _$ContactInfoToJson(ContactInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contactName': instance.contactName,
      'relation': instance.relation,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
    };

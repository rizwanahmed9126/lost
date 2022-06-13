import 'package:json_annotation/json_annotation.dart';

part 'contact_info.g.dart';

@JsonSerializable(nullable: false)
class ContactInfo {
  String? id;
  String? contactName;
  String? relation;
  String? phoneNumber;
  String? address;

  ContactInfo({
    this.id,
    this.relation,
    this.contactName,
    this.phoneNumber,
    this.address,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) =>
      _$ContactInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ContactInfoToJson(this);
}

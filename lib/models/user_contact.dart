import 'package:json_annotation/json_annotation.dart';

part 'user_contact.g.dart';

// ignore: deprecated_member_use
@JsonSerializable(nullable: false)
class AddContact {
  String? id;
  String? name;
  String? relation;
  String? phoneNumber;
  String? address;

  Map<String, dynamic>? package;

  AddContact({
    this.name,
    this.id,
    this.relation,
    this.phoneNumber,
    this.address,
  });

  factory AddContact.fromJson(Map<String, dynamic> json) =>
      _$AddContactFromJson(json);
  Map<String, dynamic> toJson() => _$AddContactToJson(this);
}

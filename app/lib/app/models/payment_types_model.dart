// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentTypesModel {
  final int id;
  final String name;
  final String acronym;
  final bool enable;

  PaymentTypesModel({
    required this.id,
    required this.name,
    required this.acronym,
    required this.enable,
  });

 

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'acronym': acronym,
      'enable': enable,
    };
  }

  factory PaymentTypesModel.fromMap(Map<String, dynamic> map) {
    return PaymentTypesModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      acronym: map['acronym'] ?? '',
      enable: map['enable'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentTypesModel.fromJson(String source) => PaymentTypesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

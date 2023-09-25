import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EditModel {
  String? body;
  EditModel({
    this.body,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
    };
  }

  factory EditModel.fromMap(Map<String, dynamic> map) {
    return EditModel(
      body: map['body'] != null ? map['body'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditModel.fromJson(String source) => EditModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

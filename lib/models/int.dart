import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Articlecount {
  int? count;
  Articlecount({
    this.count,
  });



  Articlecount.fromMap(Map<String, dynamic> map) {
    count = map['articlesCount'];
  }
}

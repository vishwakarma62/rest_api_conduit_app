import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginResponseModel {
  User? user;

  LoginResponseModel({required this.user});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? email;
  String? username;
  String? bio;
  String? password;
  String? image;
  String? token;

  User(
      {this.email,
      this.password,
      this.username,
      this.bio,
      this.image,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    bio = json['bio'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    data['bio'] = this.bio;
    data['image'] = this.image;
    data['token'] = this.token;
    return data;
  }
}

class LoginRequestModel {
  User2? user;

  LoginRequestModel({required this.user});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User2.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User2 {
  String? email;

  String? password;

  User2({
    required this.email,
    required this.password,
  });

  User2.fromJson(Map<String, dynamic> json) {
    email = json['email'];

    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;

    data['password'] = this.password;

    return data;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api_conduit_app/config/const.dart';
import 'package:rest_api_conduit_app/models/authmodel.dart';
import 'package:rest_api_conduit_app/service/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/loginmodel.dart';

abstract class AuthRepo {
  Future<dynamic> login(AuthModel loginRequestModel);
  Future<dynamic> signup(AuthModel signupRequestModel);
}

class AuthImpl extends AuthRepo {
  Future login(AuthModel loginRequestModel) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = loginRequestModel.toJson();
    print(body);

    http.Response response =
        await AuthClient.instance.doPost(ApiConstant.LoginUrl, body);
    dynamic jsonData = jsonDecode(response.body);
   
    dynamic json = jsonData['user'];
    print(jsonData['user']);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', json['email']);
    prefs.setString('token', json['token']);
    prefs.setString('username', json['username']);
    prefs.setString('bio', json['bio']);
    print(prefs.getString('token'));

    return response;
  }

  //SignUP
  Future signup(AuthModel signupRequestModel) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = signupRequestModel.toJson();

    http.Response response =
        await AuthClient.instance.doPost(ApiConstant.SignUpUrl, body);
    dynamic jsonData = jsonDecode(response.body);

    return response;
  }
}

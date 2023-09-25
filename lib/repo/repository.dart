import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api_conduit_app/config/const.dart';
import 'package:rest_api_conduit_app/models/conduitmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/comment.dart';
import '../models/int.dart';
import '../service/service.dart';

abstract class Articlerepo {
  Future<dynamic> favourite();
  Future<dynamic> addfavourite(String _slug);
  Future<dynamic> unfavourite(String _slug);
  Future<dynamic> editArticle(AllArticlesModel _articlemodel, String _slug);
  Future<dynamic> deleteArticle(String _slug);
  Future<dynamic> createArticlebyslug(String _slug);
}

class ArticleRepository extends Articlerepo {
  var baseUrl = 'https://api.realworld.io/api/articles';

  Future<List<AllArticlesModel>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.getString('token');
    print(jsontoken);
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jsontoken',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Parse the JSON response into a map

      final List<dynamic> data = jsonResponse['articles'];

      // Extract the 'articles' key, which should be a list

      return data.map((e) => AllArticlesModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Future<dynamic> favourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.getString('token');
    dynamic jsonusername = prefs.getString('username');
    print(jsonusername);

    http.Response response = await http
        .get(Uri.parse(ApiConstant.favouriteUrl + jsonusername), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jsontoken',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      final List<dynamic> data = jsonResponse['articles'];
      print(data);

      return data.map((e) => AllArticlesModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Future addfavourite(String _slug) async {
    print(_slug);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.get('token');

    http.Response response = await http.post(
        Uri.parse(
          ApiConstant.favfirsturl + _slug + ApiConstant.favsecondurl,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jsontoken',
        });

    return response;
  }

  @override
  Future unfavourite(String _slug) async {
    print(_slug);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.get('token');

    http.Response response = await http.delete(
        Uri.parse(
          ApiConstant.favfirsturl + _slug + ApiConstant.favsecondurl,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jsontoken',
        });

    return response;
  }

  Future likeArticle(String slug) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.get('token');

    String url = ApiConstant.favfirsturl + slug + "/favorite";
    // print(url);
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${jsontoken}"
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to like article');
    }
  }

  Future removeLikeArticle(String slug) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.get('token');

    String url = ApiConstant.favfirsturl + slug + "/favorite";
    // print(url);
    http.Response response = await http.delete(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${jsontoken}"
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to unlike article');
    }
  }

  @override
  Future editArticle(
    AllArticlesModel _articlemodel,
    String _slug,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.get('token');

    String url = ApiConstant.favfirsturl + _slug;
    Map<String, dynamic> body = _articlemodel.toJson();
    print(body);
    print(_slug);

    http.Response response = await http.put(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${jsontoken}"
      },
      body: jsonEncode({'article': body}),
    );
    // dynamic setdata = jsonEncode({'article': body});
    dynamic jsondata=response.body;
   // print(jsondata['article']);
  // dynamic jsondata=setdata['slug'];
  // print(jsondata);
   
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to edit article');
    }
  }

  @override
  Future deleteArticle(
    String _slug,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.get('token');

    String url = ApiConstant.favfirsturl + _slug;

    print(_slug);

    http.Response response = await http.delete(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${jsontoken}"
      },
    );

    print(response.body);
    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete article');
    }
  }

  @override
  Future createArticle(
    AllArticlesModel _articlemodel,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.get('token');

    String url = ApiConstant.favfirsturl;
    Map<String, dynamic> body = _articlemodel.toJson();
    print(body);

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${jsontoken}"
      },
      body: jsonEncode({'article': body}),
    );
    dynamic setdata = jsonEncode({'article': body});
    print(setdata);
    print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create article');
    }
  }

  @override
  Future<dynamic> createArticlebyslug(String _slug) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.getString('token');
    print(jsontoken);
    print(_slug);
    String url = ApiConstant.favfirsturl + _slug;
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jsontoken',
    });

    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);
      print(response.body);

      // Parse the JSON response into a map

      dynamic data = jsonResponse['article'];

      // Extract the 'articles' key, which should be a list

      return AllArticlesModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}

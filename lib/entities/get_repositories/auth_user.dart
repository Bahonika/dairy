import 'dart:convert';
import 'dart:io';

import 'package:dairy/entities/abstract/api.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../get_enitites/user.dart';

class AuthorizationException implements Exception {
  String getErrorMessage() {
    return "Неверные данные пользователя";
  }
}

class AuthUser extends Api {
  @override
  final String apiEndpoint = "auth/login";

  Future<AuthorizedUser> auth(String email, String password) async {
    var uri = Uri.http(Api.siteRoot, apiPath());
    var response = await http.post(uri,
        body: jsonEncode({'email': email, 'password': password}),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    var status = response.statusCode;
    if (response.statusCode == 200) {
      return AuthorizedUser.fromJson(convert.jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw AuthorizationException();
    }
    throw HttpException("can't access $uri Status: $status");
  }
}

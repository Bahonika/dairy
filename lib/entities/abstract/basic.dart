import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:dairy/entities/abstract/api.dart';

import '../get_enitites/user.dart';

abstract class BasicRepository<T> extends Api {
  Uri apiIdPath(String id) => Uri.http(
        Api.siteRoot,
        "$apiEndpoint/$id",
      );

  T fromJson(json);

  Future<List<T>> getAll(
      {Map<String, String>? queryParams,
      AuthorizedUser? user,
      additionalEndpoint = ""}) async {
    var uri =
        Uri.http(Api.siteRoot, apiPath() + additionalEndpoint, queryParams);
    http.Response response;
    try {
      response = await http.get(uri, headers: {
        "Content-Type": "application/json",
        'Authorization': user!.token
      });
    } catch (e) {
      throw Exception("Cant do this");
    }
    var status = response.statusCode;
    if (status == 200) {
      List<T> list = [];
      var json = convert.jsonDecode(response.body);
      for (final item in json) {
        list.add(fromJson(item));
      }
      return list;
    }
    throw HttpException("can't access $uri Status: $status");
  }

  Future<T> getData(
      {Map<String, String>? queryParams,
      AuthorizedUser? user,
      additionalEndpoint = ""}) async {
    var uri =
        Uri.http(Api.siteRoot, apiPath() + additionalEndpoint, queryParams);
    http.Response response;
    try {
      response = await http.get(uri, headers: {
        "Content-Type": "application/json",
        'Authorization': user!.token
      });
    } catch (e) {
      throw Exception("Cant do this");
    }

    var status = response.statusCode;
    if (status == 200) {
      var json = convert.jsonDecode(response.body);
      return fromJson(json);
    }
    throw HttpException("can't access $uri Status: $status");
  }
}

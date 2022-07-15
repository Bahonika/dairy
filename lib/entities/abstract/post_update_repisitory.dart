import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dairy/entities/abstract/basic.dart';

import '../../entities/abstract/postable.dart';
import '../get_enitites/user.dart';
import 'api.dart';

abstract class PostUpdateRepository<T extends Postable>
    extends BasicRepository<T> {
  String get idAlias;

  Future<int> create(T entity, AuthorizedUser user,
      {String additionalEndpoint = ""}) async {
    print(Api.siteRoot);

    var uri = Uri.http(Api.siteRoot, apiPath() + additionalEndpoint);

    print("hello$uri");
    var response = await http.post(
      uri,
      body: jsonEncode(entity.toJson()),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: user.token
      },
    );
    var status = response.statusCode;
    var body = jsonDecode(response.body);

    if (status == 200) {
      return body["id"];
    }
    throw HttpException("can't post to $uri Status: $status");
  }

  Future<void> update(T entity, String id, AuthorizedUser user) async {
    var response = await http.put(apiIdPath(id),
        headers: {
          HttpHeaders.authorizationHeader: user.token,
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(entity.toJson()));
    var status = response.statusCode;
    if (status != 200) {
      throw HttpException("can't update to Status: $status");
    }
  }

  Future<void> delete(String id, AuthorizedUser user,
      {additionalEndpoint = ""}) async {
    var response = await http
        .delete(apiIdPath(id), headers: {'Authorization': user.token});
    var status = response.statusCode;
    if (status != 201 && status != 200 && status != 202) {
      throw HttpException("can't delete, status: $status");
    }
  }
}

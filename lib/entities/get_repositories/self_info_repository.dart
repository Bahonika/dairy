import 'package:dairy/entities/abstract/basic.dart';
import 'package:dairy/entities/get_enitites/self_info.dart';

class SelfInfoRepository extends BasicRepository<UserInfo> {
  @override
  final String apiEndpoint = "api/user";

  @override
  UserInfo fromJson(json) {
    return UserInfo.fromJson(json);
  }
}

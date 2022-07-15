import 'package:dairy/entities/get_enitites/theme.dart';

import '../abstract/basic.dart';

class ThemeRepository extends BasicRepository<ThemeEntity> {
  @override
  final String apiEndpoint = "api/user";

  @override
  ThemeEntity fromJson(json) {
    return ThemeEntity.fromJson(json);
  }
}

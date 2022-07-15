import '../abstract/basic.dart';
import '../get_enitites/dream.dart';

class DreamRepository extends BasicRepository<Dream>{

  @override
  final String apiEndpoint = "api/dream";

  @override
  Dream fromJson(json) {
    return Dream.fromJson(json);
  }
}
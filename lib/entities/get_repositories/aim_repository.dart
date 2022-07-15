import '../abstract/basic.dart';
import '../get_enitites/aim.dart';

class AimRepository extends BasicRepository<Aim> {
  @override
  final String apiEndpoint = "api/aim";

  @override
  Aim fromJson(json) {
    return Aim.fromJson(json);
  }
}

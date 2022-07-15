import '../abstract/basic.dart';
import '../get_enitites/idea.dart';

class IdeaRepository extends BasicRepository<Idea>{

  @override
  final String apiEndpoint = "api/idea";

  @override
  Idea fromJson(json) {
    return Idea.fromJson(json);
  }
}
import 'package:dairy/entities/abstract/basic.dart';
import 'package:dairy/entities/get_enitites/memory.dart';

class MemoryRepository extends BasicRepository<Memory> {
  @override
  final String apiEndpoint = "api/memory";

  @override
  Memory fromJson(json) {
    return Memory.fromJson(json);
  }
}

import '../abstract/postable.dart';

class AimPost implements Postable {
  final String name;
  final String deadline;

  AimPost({required this.name, required this.deadline});

  @override
  Map<String, dynamic> toJson() {
    var map = {
      'name': name,
      'deadline': deadline,
    };

    return map;
  }
}

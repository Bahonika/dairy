import '../abstract/postable.dart';

class TaskPost implements Postable {
  final String name;
  final String deadline;
  final String status;

  TaskPost({required this.name, required this.deadline, required this.status});

  @override
  Map<String, dynamic> toJson() {
    var map = {'name': name, 'deadline': deadline, 'status': status};

    return map;
  }
}

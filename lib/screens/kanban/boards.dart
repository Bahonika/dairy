// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:dairy/entities/get_enitites/aim.dart';
// import 'package:dairy/entities/get_enitites/task.dart';
// import 'package:dairy/entities/get_enitites/user.dart';
// import 'package:dairy/entities/post_entities/task_post.dart';
// import 'package:dairy/entities/post_repositories/task_post_repository.dart';
// import 'package:dairy/screens/kanban/task_widget.dart';
//
// import 'bar_target.dart';
//
// /// This widget displays the actual
// /// boards. It is passed which boards exist
// /// and which tasks they contain.
// class Boards extends StatefulWidget {
//   final Map<String, List<Task>> boards;
//   final Aim aim;
//   final AuthorizedUser user;
//
//   const Boards(
//       {Key? key, required this.boards, required this.aim, required this.user})
//       : super(key: key);
//   @override
//   State<Boards> createState() => _BoardsState();
// }
//
// class _BoardsState extends State<Boards> {
//   var dragging = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   late TaskPostRepository taskPostRepository = TaskPostRepository();
//
//   changeStatus(Task task, String status) {
//     TaskPost taskPost = TaskPost(
//         name: task.name, deadline: task.deadline.toString(), status: status);
//     taskPostRepository.update(taskPost, "${task.id}", widget.user);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     /// On mobile devices, the boards will scroll horizontally
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Row(
//             children: widget.boards.keys
//                 .map((name) => DragTarget<List<dynamic>>(
//                       onWillAccept: (data) => true,
//
//                       /// Actually moving tasks happens here. The payload of a task is a List<String> which contains
//                       /// the task's contents and its category
//                       onAccept: (data) {
//                         setState(() {
//                           changeStatus(data[0], name);
//                           widget.boards[data[1]]!.remove(data[0]);
//                           widget.boards[name]!.add(data[0]);
//                         });
//                       },
//                       builder: (context, candidateData, rejectedData) =>
//                           Container(
//                         decoration: const BoxDecoration(
//                             border:
//                                 Border(right: BorderSide(color: Colors.white))),
//
//                         /// A board's width is at least 200 logical pixels
//                         /// or 1/number of boards of the entire screen width
//                         width: max(
//                             MediaQuery.of(context).size.width /
//                                 widget.boards.keys.length,
//                             200),
//                         child: ListView(
//                           children: <Widget>[
//                             ListTile(
//                                 title: Text(
//                               name,
//                               style: const TextStyle(color: Colors.white),
//                             )),
//                             const Divider(
//                               color: Colors.white,
//                             ),
//                             ...widget.boards[name]!.map(
//                               /// The callbacks are used to determine if the Delete Bar should be shown
//                               (t) => TaskWidget(
//                                 tasks: [t, name],
//                                 dragStartedCallback: () {
//                                   setState(() {
//                                     dragging = true;
//                                   });
//                                 },
//                                 dragEndCallback: (details) =>
//                                     setState(() => dragging = false),
//                                 width: max(
//                                     (MediaQuery.of(context).size.width /
//                                             widget.boards.keys.length) +
//                                         20,
//                                     220),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ))
//                 .toList(),
//           ),
//           if (dragging)
//             BarTarget<List<Task>>(
//               width: max(MediaQuery.of(context).size.width,
//                   widget.boards.keys.length * 200.0),
//               height: 64,
//               color: Colors.red,
//               child: const Icon(Icons.delete),
//               onAccept: (data) {
//                 widget.boards[data[1]]?.remove(data[0]);
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }

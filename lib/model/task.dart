import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
   required this.id,
   required this.title,
   required this.description,
   required this.createdAtTime,
   required this.createdAtDate,
   required this.isCompleted,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  DateTime createdAtTime;
  @HiveField(4)
  DateTime createdAtDate;
  @HiveField(5)
  bool isCompleted;

  factory Task.create({
    required String? title,
    required String? description,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) =>
      Task(
        id: const Uuid().v1(),
        title: title ?? "",
        description: description ?? "",
        createdAtTime: createdAtTime ?? DateTime.now(),
        createdAtDate: createdAtDate ?? DateTime.now(),
        isCompleted: false, 
      );

}

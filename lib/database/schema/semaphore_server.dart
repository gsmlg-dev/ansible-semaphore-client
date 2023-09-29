import 'package:isar/isar.dart';

part 'semaphore_server.g.dart';

@collection
class SemaphoreServer {
  Id id = Isar.autoIncrement;

  String? name;

  String? apiUrl;

  bool? isActive;

  String? username;

  String? password;

  String? token;

  DateTime createdAt = DateTime.now();
}

import 'package:isar/isar.dart' show CollectionSchema;
import 'package:semaphore/database/schema/semaphore_server.dart';
import 'package:semaphore/database/schema/app_activities.dart';

const List<CollectionSchema> allSchema = [
  AppActivitiesSchema,
  SemaphoreServerSchema
];

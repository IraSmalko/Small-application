import 'dart:async';

import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:small_application/database/user_dao.dart';
import 'package:small_application/models/user.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [User])
abstract class FlutterDatabase extends FloorDatabase {
  UserDao get userDao;
}

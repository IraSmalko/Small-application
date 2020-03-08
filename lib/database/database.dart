import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:small_application/database/model/db_user.dart';
import 'package:small_application/database/user_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [DbUser])
abstract class FlutterDatabase extends FloorDatabase {
  UserDao get userDao;

  static FlutterDatabase of(BuildContext context) =>
      RepositoryProvider.of(context);
}

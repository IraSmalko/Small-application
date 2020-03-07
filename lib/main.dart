import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:small_application/bloc/bloc.dart';
import 'package:small_application/database/database.dart';
import 'package:small_application/repository/repository.dart';
import 'package:small_application/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_application/screens/age_screen.dart';

import 'database/user_dao.dart';
import 'utils/file_loader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorFlutterDatabase
      .databaseBuilder('database.db')
      .addCallback(Callback(onOpen: (d) => d.delete('user')))
      .build();
  final dao = database.userDao;
  await _initDatabase(dao);

  runApp(MyApp(dao));
}

_initDatabase(UserDao userDao) async {
  final data = await loadAsset();
  List<User> users =
      json.decode(data).map<User>((_) => User.fromJson(_)).toList();
  await userDao.insertUsers(users);
}

class MyApp extends StatelessWidget {
  final UserDao dao;

  const MyApp(this.dao);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBloc(RepositoryImpl(dao)),
      child: MaterialApp(
        title: 'Small application',
        home: AgeScreen(),
      ),
    );
  }
}

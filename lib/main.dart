import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:small_application/bloc/data_bloc.dart';
import 'package:small_application/database/database.dart';
import 'package:small_application/repository/repository.dart';
import 'package:small_application/database/model/db_user.dart';
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
  List<DbUser> users =
      json.decode(data).map<DbUser>((json) => DbUser.fromJson(json)).toList();
  await userDao.insertUsers(users);
}

class MyApp extends StatelessWidget {
  final UserDao dao;

  const MyApp(this.dao);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Repository>(
      create: (context) => RepositoryImpl(dao),
      child: BlocProvider(
        create: (context) => DataBloc(Repository.of(context)),
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            fontFamily: 'Oswald',
          ),
          title: 'Small application',
          home: AgeScreen(),
        ),
      ),
    );
  }
}

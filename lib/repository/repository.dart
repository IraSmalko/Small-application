import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_application/database/model/db_user.dart';
import 'package:small_application/database/user_dao.dart';
import 'package:small_application/models/user.dart';

abstract class Repository {
  Stream<List<User>> getUsers();

  Future<void> deleteUser(User user);

  Future<void> insertUser(User user);

  static Repository of(BuildContext context) => RepositoryProvider.of(context);
}

class RepositoryImpl extends Repository {
  final UserDao dao;

  RepositoryImpl(this.dao);

  @override
  Stream<List<User>> getUsers() => dao
      .findAllUsersAsStream()
      .map((list) => list.map((dbUser) => dbUser.toLocal()).toList());

  @override
  Future<void> deleteUser(User user) => dao.deleteUser(DbUser.fromLocal(user));

  @override
  Future<void> insertUser(User user) => dao.insertUser(DbUser.fromLocal(user));
}

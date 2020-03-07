import 'package:small_application/database/user_dao.dart';
import 'package:small_application/models/user.dart';

abstract class Repository {
  Stream<List<User>> getUsers();

  Future<void> deleteUser(User user);

  Future<void> insertUser(User user);
}

class RepositoryImpl extends Repository {
  final UserDao dao;

  RepositoryImpl(this.dao);

  @override
  Stream<List<User>> getUsers() => dao.findAllUsersAsStream();

  @override
  Future<void> deleteUser(User user) => dao.deleteUser(user);

  @override
  Future<void> insertUser(User user) => dao.insertUser(user);
}

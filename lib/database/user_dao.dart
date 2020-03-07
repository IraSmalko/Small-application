import 'package:floor/floor.dart';
import 'package:small_application/models/user.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM user WHERE id = :id')
  Future<User> findUserById(int id);

  @Query('SELECT * FROM user')
  Stream<List<User>> findAllUsersAsStream();

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertUser(User user);

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertUsers(List<User> users);

  @delete
  Future<void> deleteUser(User user);
}

import 'package:floor/floor.dart';
import 'package:small_application/database/model/db_user.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM user WHERE id = :id')
  Future<DbUser> findUserById(int id);

  @Query('SELECT * FROM user')
  Stream<List<DbUser>> findAllUsersAsStream();

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertUser(DbUser user);

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> insertUsers(List<DbUser> users);

  @delete
  Future<void> deleteUser(DbUser user);
}

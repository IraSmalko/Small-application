import 'package:floor/floor.dart';
import 'package:small_application/models/user.dart';
import 'package:meta/meta.dart';

@Entity(tableName: 'user')
class DbUser {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final int age;
  final String car;

  DbUser({
    @required this.id,
    @required this.name,
    @required this.age,
    @required this.car,
  });

  User toLocal() {
    return User(
      id: this.id,
      name: this.name,
      age: this.age,
      car: this.car,
    );
  }

  static DbUser fromJson(Map<String, dynamic> map) {
    return DbUser(
      id: null,
      name: map['name'],
      age: map['age'],
      car: map['car'],
    );
  }

  static DbUser fromLocal(User user) {
    return DbUser(
      id: user.id,
      name: user.name,
      age: user.age,
      car: user.car,
    );
  }
}

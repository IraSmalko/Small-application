import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';

@Entity(tableName: 'user')
class User {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final int age;
  final String car;

  User({
    @required this.id,
    @required this.name,
    @required this.age,
    @required this.car,
  });

  static User fromJson(Map<String, dynamic> map) {
    return User(
      id: null,
      name: map['name'],
      age: map['age'],
      car: map['car'],
    );
  }
}

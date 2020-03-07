import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';

@entity
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

  User copyWith({
    String name,
    int age,
    String car,
    bool isDeleting,
  }) {
    return User(
      id: this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      car: car ?? this.car,
    );
  }

  static User fromJson(Map<String, dynamic> map) {
    return User(
      id: null,
      name: map['name'],
      age: map['age'],
      car: map['car'],
    );
  }
}

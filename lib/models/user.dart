import 'package:meta/meta.dart';

@immutable
class User {
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
}

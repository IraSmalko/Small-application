part of 'bloc.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class Loading extends DataState {}

class Loaded extends DataState {
  final List<User> users;

  const Loaded({@required this.users});

  @override
  List<Object> get props => [users];

  @override
  String toString() => 'Loaded { items: ${users.length} }';
}

class Failure extends DataState {}

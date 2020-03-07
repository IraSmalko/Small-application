part of 'bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class ErrorEvent extends DataEvent {}

class LoadedEvent extends DataEvent {
  final List<User> users;

  const LoadedEvent({@required this.users});

  @override
  List<Object> get props => [users];

  @override
  String toString() => 'Loaded { items: ${users.length} }';
}

class Delete extends DataEvent {
  final User user;

  const Delete({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Delete { id: $user }';
}

class Insert extends DataEvent {
  final User user;

  const Insert({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Insert { id: $user }';
}

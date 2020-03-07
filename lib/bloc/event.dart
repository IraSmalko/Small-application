part of 'bloc.dart';

abstract class DataEvent {
  const DataEvent();
}

class ErrorEvent extends DataEvent {}

class LoadedEvent extends DataEvent {
  final List<User> users;

  const LoadedEvent({@required this.users});

  @override
  String toString() => 'Loaded { items: ${users.length} }';
}

class Delete extends DataEvent {
  final User user;

  const Delete({@required this.user});

  @override
  String toString() => 'Delete { id: $user }';
}

class Insert extends DataEvent {
  final User user;

  const Insert({@required this.user});

  @override
  String toString() => 'Insert { id: $user }';
}

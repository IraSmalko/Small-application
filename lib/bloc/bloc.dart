import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:small_application/models/user.dart';

import '../repository/repository.dart';

part 'event.dart';

part 'state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final Repository repository;
  StreamSubscription _subscription;

  DataBloc(this.repository) {
    _subscription = repository
        .getUsers()
        .handleError((e) => ErrorEvent())
        .listen((items) => add(LoadedEvent(users: items)));
  }

  @override
  DataState get initialState => Loading();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is ErrorEvent) {
      yield Failure();
    }
    if (event is LoadedEvent) {
      yield Loaded(users: event.users);
    }
    if (event is Delete) {
      await repository.deleteUser(event.user);
    }
    if (event is Delete) {
      await repository.deleteUser(event.user);
    }
    if (event is Insert) {
      await repository.insertUser(event.user);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

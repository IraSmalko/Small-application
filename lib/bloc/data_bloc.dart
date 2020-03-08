import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_application/models/user.dart';
import 'package:small_application/repository/repository.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final Repository _repository;
  StreamSubscription _subscription;

  DataBloc(this._repository) {
    _subscription = _repository
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
      await _repository.deleteUser(event.user);
    }
    if (event is Insert) {
      await _repository.insertUser(event.user);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  static DataBloc of(BuildContext context) {
    return BlocProvider.of<DataBloc>(context);
  }
}

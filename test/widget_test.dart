import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:small_application/database/database.dart';
import 'package:small_application/database/model/db_user.dart';
import 'package:small_application/database/user_dao.dart';
import 'package:small_application/main.dart';

import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiTestInit();

  group('tests', () {
    final sasha = DbUser(id: 1, name: 'Sasha', age: 1, car: "Car");
    FlutterDatabase database;
    UserDao userDao;

    setUp(() async {
      database = await $FloorFlutterDatabase.inMemoryDatabaseBuilder().build();
      userDao = database.userDao;
      await _initDatabase(userDao, sasha);
    });

    tearDown(() async {
      await database.close();
    });

    testWidgets('initDatabase', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(userDao));
      await _awaitFrame(tester);
      expect(find.text('Sasha'), findsOneWidget);
    });

    testWidgets('insertUser', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(userDao));
      await _awaitFrame(tester);
      expect(find.text('Sasha'), findsOneWidget);
      expect(find.text('Name'), findsNothing);

      final user = DbUser(id: 2, name: 'Name', age: 2, car: "Car");
      await tester.runAsync(() => userDao.insertUser(user));
      await tester.runAsync(() async => scheduleMicrotask(() {}));

      await _awaitFrame(tester);

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Sasha'), findsOneWidget);
    });

    testWidgets('deleteUser', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(userDao));
      await _awaitFrame(tester);
      expect(find.text('Sasha'), findsOneWidget);

      await tester.runAsync(() => userDao.deleteUser(sasha));
      await tester.runAsync(() async => scheduleMicrotask(() {}));

      await _awaitFrame(tester);

      expect(find.text('Sasha'), findsNothing);
    });
  });
}

Future<void> _awaitFrame(WidgetTester tester) async {
  await tester.runAsync(() => Future<void>.delayed(Duration.zero));
  await tester.pump();
}

Future<void> _initDatabase(UserDao userDao, DbUser user) async {
  await userDao.insertUsers([user]);
}

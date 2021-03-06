// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorFlutterDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder databaseBuilder(String name) =>
      _$FlutterDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FlutterDatabaseBuilder(null);
}

class _$FlutterDatabaseBuilder {
  _$FlutterDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$FlutterDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FlutterDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FlutterDatabase> build() async {
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$FlutterDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FlutterDatabase extends FlutterDatabase {
  _$FlutterDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao _userDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `age` INTEGER, `car` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _dbUserInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (DbUser item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'age': item.age,
                  'car': item.car
                },
            changeListener),
        _dbUserDeletionAdapter = DeletionAdapter(
            database,
            'user',
            ['id'],
            (DbUser item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'age': item.age,
                  'car': item.car
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _userMapper = (Map<String, dynamic> row) => DbUser(
      id: row['id'] as int,
      name: row['name'] as String,
      age: row['age'] as int,
      car: row['car'] as String);

  final InsertionAdapter<DbUser> _dbUserInsertionAdapter;

  final DeletionAdapter<DbUser> _dbUserDeletionAdapter;

  @override
  Future<DbUser> findUserById(int id) async {
    return _queryAdapter.query('SELECT * FROM user WHERE id = ?',
        arguments: <dynamic>[id], mapper: _userMapper);
  }

  @override
  Stream<List<DbUser>> findAllUsersAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM user',
        tableName: 'user', mapper: _userMapper);
  }

  @override
  Future<void> insertUser(DbUser user) async {
    await _dbUserInsertionAdapter.insert(
        user, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<void> insertUsers(List<DbUser> users) async {
    await _dbUserInsertionAdapter.insertList(
        users, sqflite.ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteUser(DbUser user) async {
    await _dbUserDeletionAdapter.delete(user);
  }
}

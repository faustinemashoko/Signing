import 'package:mysql1/mysql1.dart';

class DBConnection {
  // Singleton pattern to avoid multiple instances of the connection
  static MySqlConnection? _connection;

  Future<MySqlConnection> dbConnect() async {
    if (_connection == null) {
      try {
        var settings = ConnectionSettings(
          host: 'localhost',
          port: 3306,
          user: 'new_user',
          db: 'project1',
          password: 'new_password',
        );

        _connection = await MySqlConnection.connect(settings);
        print('Database connection established');
      } catch (e) {
        print('Error connecting to the database: $e');
        rethrow; // Re-throw the error for higher-level handling
      }
    }
    return _connection!;
  }

  // Close the database connection
  Future<void> close() async {
    if (_connection != null) {
      await _connection!.close();
      _connection = null;
      print('Database connection closed');
    }
  }
}

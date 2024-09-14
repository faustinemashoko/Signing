import '../models/db_connection.dart';

class AuthenticationService {
  final dbConnection = DBConnection();

  Future<bool> login(String username, String password) async {
    var conn = await dbConnection.dbConnect();
    var result = await conn.query(
      "SELECT password FROM users WHERE username = ?",
      [username],
    );
    if (result.isNotEmpty) {
      var realPassword = result.first[0].toString();
      return realPassword == password.hashCode.toString();
    }
    await conn.close();
    return false;
  }

  Future<bool> authenticateUser(String email, String password) async {
    var conn = await DBConnection().dbConnect();

    var results = await conn.query(
      'SELECT password FROM users WHERE email = ?',
      [email],
    );

    if (results.isEmpty) {
      print('No user found with that email');
      return false;
    }

    var storedPassword = results.first['password'];

    if (storedPassword == password) {
      print('Login successful');
      return true;
    } else {
      print('Invalid password');
      return false;
    }
  }
}

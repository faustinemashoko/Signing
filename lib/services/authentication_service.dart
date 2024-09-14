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

  Future<bool> register(String firstName, String lastName, String username, String password) async {
    var conn = await dbConnection.dbConnect();
    var hashedPassword = password.hashCode.toString();
    var result = await conn.query(
      'INSERT INTO users (f_name, l_name, username, password) VALUES (?, ?, ?, ?)',
      [firstName, lastName, username, hashedPassword],
    );
    await conn.close();
    return result.affectedRows == 1;
  }

  Future<bool> resetPassword(String username, String newPassword) async {
    var conn = await dbConnection.dbConnect();
    var hashedPassword = newPassword.hashCode.toString();
    var result = await conn.query(
      'UPDATE users SET password = ? WHERE username = ?',
      [hashedPassword, username],
    );
    await conn.close();
    return result.affectedRows == 1;
  }
}

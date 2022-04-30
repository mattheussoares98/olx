class UserModel {
  String? _email;
  String? _name;
  String? _idUser;
  String? _password;

  Map<String, dynamic> toMap() {
    return {
      'email': _email,
      'name': _name,
      'idUser': _idUser,
      'password': _password,
    };
  }

  String get email => _email!;
  set email(value) => email = value;

  String get name => _name!;
  set name(value) => name = value;

  String get idUser => _idUser!;
  set idUser(value) => idUser = value;

  String get password => _password!;
  set password(value) => password = value;
}

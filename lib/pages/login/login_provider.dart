import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  String _errorMessage = '';

  String get errorMessage {
    return _errorMessage;
  }

  login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      _errorMessage = e.toString();
      print('Erro no login ====== $e');
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }

  register({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      _errorMessage = e.toString();
      print('Erro no cadastro ====== $e');
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }

  bool verifyIsLogged() {
    if (_auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }
}

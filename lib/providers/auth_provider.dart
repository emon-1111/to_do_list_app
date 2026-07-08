import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/services/auth_services.dart';

class AuthProvider with ChangeNotifier {
  final AuthServices _auth = AuthServices();

  bool _isLoading = false;
  String? _errorMessage;

  // getter is a  function which doesnt required () to be called
  bool get isLoading => _isLoading; 
  String? get errorMessage => _errorMessage;

  Stream<User?> get user => _auth.user;

  void _setLoading(bool value) {
    _isLoading = value;
    _errorMessage = null;
    notifyListeners();
  }

  //login
  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    try {
      await _auth.signIn(email, password);
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      _setLoading(false);
      return false;
    } catch (e) {
      _errorMessage = "an unexcepted error occured";
      _setLoading(false);
      return false;
    }
  }

  //signUp

  //login
  Future<bool> signUp(String email, String password) async {
    _setLoading(true);
    try {
      await _auth.signUp(email, password);
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      _setLoading(false);
      return false;
    } catch (e) {
      _errorMessage = "an unexcepted error occured";
      _setLoading(false);
      return false;
    }
  }

  Future<void> logOut() async {
    await _auth.logOut();
  }
}

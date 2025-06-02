import 'package:flutter/material.dart';
import 'package:quiz_battle/models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  // Mock login function
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock successful login
    if (email == 'user@example.com' && password == 'password') {
      _user = User(
        id: '1',
        name: 'John Doe',
        email: email,
        avatar: null,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Mock signup function
  Future<bool> signup(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock successful signup
    _user = User(
      id: '1',
      name: name,
      email: email,
      avatar: null,
    );
    _isLoading = false;
    notifyListeners();
    return true;
  }

  // Logout function
  void logout() {
    _user = null;
    notifyListeners();
  }

  // Update user profile
  Future<bool> updateProfile(String name, String? avatar) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (_user != null) {
      _user = User(
        id: _user!.id,
        name: name,
        email: _user!.email,
        avatar: avatar ?? _user!.avatar,
      );
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }
}


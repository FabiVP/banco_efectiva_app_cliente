import 'package:flutter/material.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/models/auth_models.dart';

enum AuthState { idle, loading, success, error }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  
  AuthState _state = AuthState.idle;
  String _errorMessage = '';
  Usuario? _usuarioActual;
  bool _isDemoMode = false;

  AuthState get state => _state;
  String get errorMessage => _errorMessage;
  Usuario? get usuarioActual => _usuarioActual;
  bool get isDemoMode => _isDemoMode;

  Future<bool> register({
    required String dni,
    required String nombres,
    required String apellidos,
    required String telefono,
    required String email,
    required String password,
  }) async {
    _state = AuthState.loading;
    notifyListeners();

    try {
      final result = await _authRepository.register(
        dni: dni,
        nombres: nombres,
        apellidos: apellidos,
        telefono: telefono,
        email: email,
        password: password,
      );
      _usuarioActual = result.usuario;
      _isDemoMode = false;
      _state = AuthState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = AuthState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login(String dni, String password) async {
    _state = AuthState.loading;
    notifyListeners();

    try {
      final result = await _authRepository.login(dni, password);
      _usuarioActual = result.usuario;
      _isDemoMode = false;
      _state = AuthState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = AuthState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> loginDemo() async {
    _state = AuthState.loading;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    _usuarioActual = Usuario(
      id: 'demo-user-001',
      codCliente: 'C9999',
      numeroDocumento: '72458901',
      nombres: 'Carlos',
      apellidos: 'Mendoza Torres',
      email: 'carlos.mendoza@efectiva.com',
      telefono: '987654321',
    );

    _isDemoMode = true;
    _state = AuthState.success;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    if (!_isDemoMode) {
      try {
        await _authRepository.logout();
      } catch (_) {
        // Ignorar errores de logout si no hay sesión activa
      }
    }
    _usuarioActual = null;
    _isDemoMode = false;
    _state = AuthState.idle;
    notifyListeners();
  }

  void resetState() {
    _state = AuthState.idle;
    _errorMessage = '';
    notifyListeners();
  }
}
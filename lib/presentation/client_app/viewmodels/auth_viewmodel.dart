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

  // Login real con Firebase
  Future<bool> login(String email, String password) async {
    _state = AuthState.loading;
    notifyListeners();

    try {
      _usuarioActual = await _authRepository.login(email, password);
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

  // Login en modo demo (sin Firebase)
  Future<bool> loginDemo() async {
    _state = AuthState.loading;
    notifyListeners();

    // Simular un pequeño delay para UX
    await Future.delayed(const Duration(milliseconds: 800));

    _usuarioActual = Usuario(
      uid: 'demo-user-001',
      email: 'carlos.mendoza@efectiva.com',
      nombreCompleto: 'Carlos Mendoza Torres',
      dni: '72458901',
      telefono: '987654321',
      fotoUrl: null,
      fechaRegistro: DateTime(2024, 3, 15),
      dispositivosConfianza: ['Samsung Galaxy S23'],
      saldoCapital: 12635.00,
      interesesAcumulados: 83.50,
      numeroCuenta: '0013592210001',
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
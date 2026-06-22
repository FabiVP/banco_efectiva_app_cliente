import 'package:flutter/foundation.dart';
import '../../../data/models/cuanta_models.dart';
import '../../../data/repositories/cuenta_repository.dart';
import '../../../core/api/api_client.dart';

enum HomeState { idle, loading, success, error }

class HomeViewModel extends ChangeNotifier {
  final CuentaRepository _repo;
  HomeState _state = HomeState.idle;
  String? _errorMessage;

  List<CuentaDigital> _cuentas = [];
  List<Movimiento> _movimientos = [];
  List<Credito> _creditos = [];
  List<TarjetaDigital> _tarjetas = [];
  List<NotificacionApp> _notificaciones = [];

  HomeViewModel({CuentaRepository? repo})
      : _repo = repo ?? CuentaRepository(api: ApiClient());

  HomeState get state => _state;
  String? get errorMessage => _errorMessage;
  List<CuentaDigital> get cuentas => _cuentas;
  List<Movimiento> get movimientos => _movimientos;
  List<Credito> get creditos => _creditos;
  List<TarjetaDigital> get tarjetas => _tarjetas;
  List<NotificacionApp> get notificaciones => _notificaciones;

  double get saldoTotal =>
      _cuentas.fold(0.0, (sum, c) => sum + c.saldoCapital);

  Future<void> loadDashboard() async {
    _state = HomeState.loading;
    notifyListeners();
    try {
      final results = await Future.wait([
        _repo.getCuentas(),
        _repo.getMovimientos(limit: 5),
        _repo.getCreditos(),
        _repo.getTarjetas(),
        _repo.getNotificaciones(),
      ]);
      _cuentas = results[0] as List<CuentaDigital>;
      _movimientos = results[1] as List<Movimiento>;
      _creditos = results[2] as List<Credito>;
      _tarjetas = results[3] as List<TarjetaDigital>;
      _notificaciones = results[4] as List<NotificacionApp>;
      _state = HomeState.success;
    } catch (e) {
      _state = HomeState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> loadCuentas() async {
    try {
      _cuentas = await _repo.getCuentas();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadMovimientos({int limit = 20}) async {
    try {
      _movimientos = await _repo.getMovimientos(limit: limit);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}

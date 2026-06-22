import 'package:flutter/foundation.dart';
import '../../../data/models/cuanta_models.dart';
import '../../../data/repositories/cuenta_repository.dart';
import '../../../core/api/api_client.dart';

enum CreditosState { idle, loading, success, error }

class CreditosViewModel extends ChangeNotifier {
  final CuentaRepository _repo;
  CreditosState _state = CreditosState.idle;
  String? _errorMessage;

  List<Credito> _creditos = [];
  List<Cuota> _cronograma = [];
  Credito? _creditoSeleccionado;

  CreditosViewModel({CuentaRepository? repo})
      : _repo = repo ?? CuentaRepository(api: ApiClient());

  CreditosState get state => _state;
  String? get errorMessage => _errorMessage;
  List<Credito> get creditos => _creditos;
  List<Cuota> get cronograma => _cronograma;
  Credito? get creditoSeleccionado => _creditoSeleccionado;

  double get totalDeuda =>
      _creditos.fold(0.0, (sum, c) => sum + (c.saldoCapital ?? 0));

  Future<void> loadCreditos() async {
    _state = CreditosState.loading;
    notifyListeners();
    try {
      _creditos = await _repo.getCreditos();
      _state = CreditosState.success;
    } catch (e) {
      _state = CreditosState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> seleccionarCredito(Credito credito) async {
    _creditoSeleccionado = credito;
    _state = CreditosState.loading;
    notifyListeners();
    try {
      _cronograma = await _repo.getCronograma(credito.codCuentaCredito);
      _state = CreditosState.success;
    } catch (e) {
      _state = CreditosState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}

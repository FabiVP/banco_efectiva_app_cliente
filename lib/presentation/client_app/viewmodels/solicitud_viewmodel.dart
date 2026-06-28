import 'dart:convert';
import 'dart:ui' show Offset;
import 'package:flutter/foundation.dart';
import '../../../data/repositories/cuenta_repository.dart';
import '../../../core/api/api_client.dart';

enum SolicitudState { idle, loading, success, error }
enum DocType { dniAnverso, dniReverso, fotoNegocio, recibo, ruc }

class DocUpload {
  final DocType tipo;
  final Uint8List bytes;
  final String nombre;
  DocUpload(this.tipo, this.bytes, this.nombre);
}

class SolicitudViewModel extends ChangeNotifier {
  final CuentaRepository _repo;
  SolicitudState _state = SolicitudState.idle;
  String? _errorMessage;
  String? _expediente;
  String? _solicitudId;

  List<DocUpload> _documentos = [];
  SolicitudState _docState = SolicitudState.idle;
  String? _docError;

  SignaturePadState _signatureState = SignaturePadState();

  // Form fields
  String _tipoNegocio = 'servicios';
  String _nombreNegocio = '';
  double _ingresosEstimados = 0;
  double? _gastosMensuales;
  double? _patrimonioEstimado;
  double _montoSolicitado = 0;
  int _plazoMeses = 12;
  String _garantia = 'sin_garantia';
  String _destinoCredito = '';

  SolicitudViewModel({CuentaRepository? repo})
      : _repo = repo ?? CuentaRepository(api: ApiClient());

  SolicitudState get state => _state;
  String? get errorMessage => _errorMessage;
  String? get expediente => _expediente;
  String? get solicitudId => _solicitudId;
  List<DocUpload> get documentos => _documentos;
  SolicitudState get docState => _docState;
  String? get docError => _docError;
  SignaturePadState get signatureState => _signatureState;

  String get tipoNegocio => _tipoNegocio;
  String get nombreNegocio => _nombreNegocio;
  double get ingresosEstimados => _ingresosEstimados;
  double? get gastosMensuales => _gastosMensuales;
  double? get patrimonioEstimado => _patrimonioEstimado;
  double get montoSolicitado => _montoSolicitado;
  int get plazoMeses => _plazoMeses;
  String get garantia => _garantia;
  String get destinoCredito => _destinoCredito;
  double get signaturePct => _documentos.length / 5.0;

  void setTipoNegocio(String v) { _tipoNegocio = v; notifyListeners(); }
  void setNombreNegocio(String v) { _nombreNegocio = v; notifyListeners(); }
  void setIngresosEstimados(double v) { _ingresosEstimados = v; notifyListeners(); }
  void setGastosMensuales(double? v) { _gastosMensuales = v; notifyListeners(); }
  void setPatrimonioEstimado(double? v) { _patrimonioEstimado = v; notifyListeners(); }
  void setMontoSolicitado(double v) { _montoSolicitado = v; notifyListeners(); }
  void setPlazoMeses(int v) { _plazoMeses = v; notifyListeners(); }
  void setGarantia(String v) { _garantia = v; notifyListeners(); }
  void setDestinoCredito(String v) { _destinoCredito = v; notifyListeners(); }

  void addDocumento(DocUpload doc) {
    _documentos.removeWhere((d) => d.tipo == doc.tipo);
    _documentos.add(doc);
    notifyListeners();
  }

  void removeDocumento(DocType tipo) {
    _documentos.removeWhere((d) => d.tipo == tipo);
    notifyListeners();
  }

  void resetSignature() {
    _signatureState = SignaturePadState();
    notifyListeners();
  }

  void updateSignaturePoints(List<Offset> points) {
    _signatureState = SignaturePadState(points: points);
    notifyListeners();
  }

  void resetForm() {
    _tipoNegocio = 'servicios';
    _nombreNegocio = '';
    _ingresosEstimados = 0;
    _gastosMensuales = null;
    _patrimonioEstimado = null;
    _montoSolicitado = 0;
    _plazoMeses = 12;
    _garantia = 'sin_garantia';
    _destinoCredito = '';
    _expediente = null;
    _solicitudId = null;
    _errorMessage = null;
    _state = SolicitudState.idle;
    _documentos = [];
    _signatureState = SignaturePadState();
    notifyListeners();
  }

  Future<void> enviarSolicitud() async {
    if (_montoSolicitado <= 0) {
      _errorMessage = 'El monto solicitado debe ser mayor a 0';
      _state = SolicitudState.error;
      notifyListeners();
      return;
    }
    _state = SolicitudState.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      final res = await _repo.crearSolicitudCredito(
        tipoNegocio: _tipoNegocio,
        nombreNegocio: _nombreNegocio,
        ingresosEstimados: _ingresosEstimados,
        gastosMensuales: _gastosMensuales,
        patrimonioEstimado: _patrimonioEstimado,
        montoSolicitado: _montoSolicitado,
        plazoMeses: _plazoMeses,
        garantia: _garantia,
        destinoCredito: _destinoCredito,
        firmaClienteBase64: _signatureState.toBase64(),
      );
      _solicitudId = res['id']?.toString();
      _expediente = res['numero_expediente']?.toString();
      _state = SolicitudState.success;
    } catch (e) {
      _state = SolicitudState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> subirDocumento(DocUpload doc) async {
    if (_solicitudId == null) return;
    _docState = SolicitudState.loading;
    notifyListeners();
    try {
      final base64 = base64Encode(doc.bytes);
      final tipoStr = doc.tipo.name
          .replaceAllMapped(RegExp(r'[A-Z]'), (m) => '_${m.group(0)!.toLowerCase()}');
      await _repo.subirDocumentoSolicitud(
        solicitudId: _solicitudId!,
        tipoDocumento: tipoStr,
        storageUrl: 'data:image/png;base64,$base64',
        tamanioKb: doc.bytes.length ~/ 1024,
      );
      _docState = SolicitudState.success;
    } catch (e) {
      _docState = SolicitudState.error;
      _docError = e.toString();
    }
    notifyListeners();
  }

  Future<void> subirTodosDocumentos() async {
    _docState = SolicitudState.loading;
    notifyListeners();
    for (final doc in _documentos) {
      try {
        await subirDocumento(doc);
      } catch (_) {}
    }
    _docState = SolicitudState.success;
    notifyListeners();
  }
}

class SignaturePadState {
  final List<Offset> points;
  SignaturePadState({this.points = const []});

  bool get isEmpty => points.isEmpty;

  String? toBase64() {
    if (isEmpty) return null;
    // This would require a rendering context to convert points to image;
    // for now we return null and the server handles it.
    return null;
  }
}

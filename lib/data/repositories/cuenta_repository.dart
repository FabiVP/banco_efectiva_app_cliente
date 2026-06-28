import '../models/cuanta_models.dart';
import '../../core/api/api_client.dart';

class CuentaRepository {
  final ApiClient _api;
  CuentaRepository({ApiClient? api}) : _api = api ?? ApiClient();

  Future<List<CuentaDigital>> getCuentas() async {
    final response = await _api.get('/cliente/cuentas');
    final list = response['data'] as List? ?? [];
    return list.map((e) => CuentaDigital.fromApi(e as Map<String, dynamic>)).toList();
  }

  Future<List<Credito>> getCreditos() async {
    final response = await _api.get('/cliente/creditos');
    final list = response['data'] as List? ?? [];
    return list.map((e) => Credito.fromApi(e as Map<String, dynamic>)).toList();
  }

  Future<List<Cuota>> getCronograma(String codCuentaCredito) async {
    final response = await _api.get('/cliente/creditos/$codCuentaCredito/cronograma');
    final list = response['data'] as List? ?? [];
    return list.map((e) => Cuota.fromApi(e as Map<String, dynamic>)).toList();
  }

  Future<List<Movimiento>> getMovimientos({int limit = 20}) async {
    final response = await _api.get('/cliente/movimientos?limit=$limit');
    final list = response['data'] as List? ?? [];
    return list.map((e) => Movimiento.fromApi(e as Map<String, dynamic>)).toList();
  }

  Future<List<TarjetaDigital>> getTarjetas() async {
    final response = await _api.get('/cliente/tarjetas');
    final list = response['data'] as List? ?? [];
    return list.map((e) => TarjetaDigital.fromApi(e as Map<String, dynamic>)).toList();
  }

  Future<List<NotificacionApp>> getNotificaciones() async {
    final response = await _api.get('/cliente/notificaciones');
    final list = response['data'] as List? ?? [];
    return list.map((e) => NotificacionApp.fromApi(e as Map<String, dynamic>)).toList();
  }

  Future<Map<String, dynamic>> crearOperacion({
    required String codCuentaOrigen,
    String? codCuentaDestino,
    required String tipo,
    required double monto,
    String moneda = 'PEN',
    String? concepto,
    String? canal,
  }) async {
    return await _api.post('/cliente/operaciones', body: {
      'cod_cuenta_origen': codCuentaOrigen,
      'cod_cuenta_destino': codCuentaDestino,
      'tipo': tipo,
      'monto': monto,
      'moneda': moneda,
      'concepto': concepto,
      'canal': canal,
    });
  }

  Future<Map<String, dynamic>> crearSolicitudCredito({
    required String tipoNegocio,
    required String nombreNegocio,
    required double ingresosEstimados,
    double? gastosMensuales,
    double? patrimonioEstimado,
    required double montoSolicitado,
    required int plazoMeses,
    String moneda = 'PEN',
    String tipoCuota = 'mensual',
    String garantia = 'sin_garantia',
    String destinoCredito = '',
    double? cuotaEstimada,
    double? teaReferencial,
    String? firmaClienteBase64,
  }) async {
    final body = <String, dynamic>{
      'tipo_negocio': tipoNegocio,
      'nombre_negocio': nombreNegocio,
      'ingresos_estimados': ingresosEstimados,
      'monto_solicitado': montoSolicitado,
      'plazo_meses': plazoMeses,
      'moneda': moneda,
      'tipo_cuota': tipoCuota,
      'garantia': garantia,
      'destino_credito': destinoCredito,
    };
    if (gastosMensuales != null) body['gastos_mensuales'] = gastosMensuales;
    if (patrimonioEstimado != null) body['patrimonio_estimado'] = patrimonioEstimado;
    if (cuotaEstimada != null) body['cuota_estimada'] = cuotaEstimada;
    if (teaReferencial != null) body['tea_referencial'] = teaReferencial;
    if (firmaClienteBase64 != null) body['firma_cliente_base64'] = firmaClienteBase64;
    return await _api.post('/cliente/solicitudes', body: body);
  }

  Future<Map<String, dynamic>> subirDocumentoSolicitud({
    required String solicitudId,
    required String tipoDocumento,
    String storageUrl = '',
    int? tamanioKb,
    double? nitidezScore,
  }) async {
    final body = <String, dynamic>{
      'tipo_documento': tipoDocumento,
      'storage_url': storageUrl,
    };
    if (tamanioKb != null) body['tamanio_kb'] = tamanioKb;
    if (nitidezScore != null) body['nitidez_score'] = nitidezScore;
    return await _api.post('/cliente/solicitudes/$solicitudId/documentos', body: body);
  }
}

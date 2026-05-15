class CuentaDigital {
  final String numeroCuenta; // 0013592210001
  final double saldoCapital;
  final double interesesAcumulados;
  final String moneda; // Soles o Dólares

  CuentaDigital({
    required this.numeroCuenta,
    required this.saldoCapital,
    required this.interesesAcumulados,
    this.moneda = 'Soles',
  });

  double get saldoTotal => saldoCapital + interesesAcumulados;
  
  String get saldoFormateado => 'S/ ${saldoCapital.toStringAsFixed(2)}';
  String get interesesFormateados => 'S/ ${interesesAcumulados.toStringAsFixed(2)}';
}

class Transaccion {
  final String id;
  final String descripcion;
  final double monto;
  final DateTime fecha;
  final String tipo; // 'ingreso', 'gasto', 'transferencia'
  final String? destinatario;

  Transaccion({
    required this.id,
    required this.descripcion,
    required this.monto,
    required this.fecha,
    required this.tipo,
    this.destinatario,
  });

  bool get esIngreso => tipo == 'ingreso';
  bool get esGasto => tipo == 'gasto';
}
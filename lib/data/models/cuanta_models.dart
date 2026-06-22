class CuentaDigital {
  final String id;
  final String codCuentaAhorro;
  final String? tipoCuenta;
  final String moneda;
  final double saldoCapital;
  final double? saldoInteres;
  final double? tea;
  final String? estado;

  CuentaDigital({
    required this.id,
    required this.codCuentaAhorro,
    this.tipoCuenta,
    this.moneda = 'PEN',
    this.saldoCapital = 0,
    this.saldoInteres,
    this.tea,
    this.estado,
  });

  double get saldoTotal => saldoCapital + (saldoInteres ?? 0);
  String get saldoFormateado => 'S/ ${saldoCapital.toStringAsFixed(2)}';
  String get monedaSimbolo => moneda == 'USD' ? 'US\$' : 'S/';

  factory CuentaDigital.fromApi(Map<String, dynamic> json) {
    return CuentaDigital(
      id: json['id']?.toString() ?? '',
      codCuentaAhorro: json['cod_cuenta_ahorro']?.toString() ?? '',
      tipoCuenta: json['tipo_cuenta']?.toString(),
      moneda: json['moneda']?.toString() ?? 'PEN',
      saldoCapital: (json['saldo_capital'] ?? 0).toDouble(),
      saldoInteres: (json['saldo_interes'] ?? 0).toDouble(),
      tea: (json['tea'] ?? 0).toDouble(),
      estado: json['estado']?.toString(),
    );
  }
}

class Credito {
  final String id;
  final String codCuentaCredito;
  final String? producto;
  final double? montoDesembolsado;
  final double? saldoCapital;
  final double? saldoTotal;
  final int diasMora;
  final String? calificacionInterna;
  final String? estado;
  final String? fechaDesembolso;
  final double? tea;
  final int? cuotasTotal;
  final int? cuotasPagadas;

  Credito({
    required this.id,
    required this.codCuentaCredito,
    this.producto,
    this.montoDesembolsado,
    this.saldoCapital,
    this.saldoTotal,
    this.diasMora = 0,
    this.calificacionInterna,
    this.estado,
    this.fechaDesembolso,
    this.tea,
    this.cuotasTotal,
    this.cuotasPagadas,
  });

  double get saldoPendiente => saldoCapital ?? 0;
  double get porcentajePagado =>
      (cuotasTotal != null && cuotasTotal! > 0)
          ? ((cuotasPagadas ?? 0) / cuotasTotal! * 100)
          : 0;
  String get estadoLabel {
    switch (estado) {
      case 'vigente': return 'Al día';
      case 'vencido': return 'Vencido';
      case 'pagado': return 'Pagado';
      default: return estado ?? '---';
    }
  }

  factory Credito.fromApi(Map<String, dynamic> json) {
    return Credito(
      id: json['id']?.toString() ?? '',
      codCuentaCredito: json['cod_cuenta_credito']?.toString() ?? '',
      producto: json['producto']?.toString(),
      montoDesembolsado: (json['monto_desembolsado'] ?? 0).toDouble(),
      saldoCapital: (json['saldo_capital'] ?? 0).toDouble(),
      saldoTotal: (json['saldo_total'] ?? 0).toDouble(),
      diasMora: json['dias_mora'] ?? 0,
      calificacionInterna: json['calificacion_interna']?.toString(),
      estado: json['estado']?.toString(),
      fechaDesembolso: json['fecha_desembolso']?.toString(),
      tea: (json['tea'] ?? 0).toDouble(),
      cuotasTotal: json['cuotas_total'],
      cuotasPagadas: json['cuotas_pagadas'],
    );
  }
}

class Cuota {
  final String id;
  final String codCuentaCredito;
  final int nroCuota;
  final String fechaVencimiento;
  final double? montoCuota;
  final double? montoCapital;
  final double? montoInteres;
  final double? saldo;
  final String? estadoCuota;
  final String? fechaPago;

  Cuota({
    required this.id,
    required this.codCuentaCredito,
    required this.nroCuota,
    required this.fechaVencimiento,
    this.montoCuota,
    this.montoCapital,
    this.montoInteres,
    this.saldo,
    this.estadoCuota,
    this.fechaPago,
  });

  bool get esPagada => estadoCuota == 'pagado';
  String get estadoLabel {
    switch (estadoCuota) {
      case 'pagado': return 'Pagado';
      case 'pendiente': return 'Pendiente';
      case 'vencido': return 'Vencido';
      default: return estadoCuota ?? '---';
    }
  }

  factory Cuota.fromApi(Map<String, dynamic> json) {
    return Cuota(
      id: json['id']?.toString() ?? '',
      codCuentaCredito: json['cod_cuenta_credito']?.toString() ?? '',
      nroCuota: json['nro_cuota'] ?? 0,
      fechaVencimiento: json['fecha_vencimiento']?.toString() ?? '',
      montoCuota: (json['monto_cuota'] ?? 0).toDouble(),
      montoCapital: (json['monto_capital'] ?? 0).toDouble(),
      montoInteres: (json['monto_interes'] ?? 0).toDouble(),
      saldo: (json['saldo'] ?? 0).toDouble(),
      estadoCuota: json['estado_cuota']?.toString(),
      fechaPago: json['fecha_pago']?.toString(),
    );
  }
}

class Movimiento {
  final String id;
  final String codOperacion;
  final String? codCuenta;
  final String? tipo;
  final String? concepto;
  final String? canal;
  final double monto;
  final String? moneda;
  final String fechaOperacion;

  Movimiento({
    required this.id,
    required this.codOperacion,
    this.codCuenta,
    this.tipo,
    this.concepto,
    this.canal,
    required this.monto,
    this.moneda,
    required this.fechaOperacion,
  });

  bool get esIngreso => tipo == 'CRE';
  bool get esGasto => tipo == 'DEB' || tipo == 'TRF';
  String get tipoLabel {
    switch (tipo) {
      case 'CRE': return 'ingreso';
      case 'DEB': return 'gasto';
      case 'TRF': return 'transferencia';
      default: return tipo ?? '---';
    }
  }

  factory Movimiento.fromApi(Map<String, dynamic> json) {
    return Movimiento(
      id: json['id']?.toString() ?? '',
      codOperacion: json['cod_operacion']?.toString() ?? '',
      codCuenta: json['cod_cuenta']?.toString(),
      tipo: json['tipo']?.toString(),
      concepto: json['concepto']?.toString(),
      canal: json['canal']?.toString(),
      monto: (json['monto'] ?? 0).toDouble(),
      moneda: json['moneda']?.toString(),
      fechaOperacion: json['fecha_operacion']?.toString() ?? '',
    );
  }
}

class TarjetaDigital {
  final String id;
  final String numeroEnmascarado;
  final String? marca;
  final double? lineaCredito;
  final double? saldoUtilizado;
  final String? fechaCorte;
  final String? fechaPago;
  final String? estado;

  TarjetaDigital({
    required this.id,
    required this.numeroEnmascarado,
    this.marca,
    this.lineaCredito,
    this.saldoUtilizado,
    this.fechaCorte,
    this.fechaPago,
    this.estado,
  });

  double get saldoDisponible => (lineaCredito ?? 0) - (saldoUtilizado ?? 0);

  factory TarjetaDigital.fromApi(Map<String, dynamic> json) {
    return TarjetaDigital(
      id: json['id']?.toString() ?? '',
      numeroEnmascarado: json['numero_enmascarado']?.toString() ?? '',
      marca: json['marca']?.toString(),
      lineaCredito: (json['linea_credito'] ?? 0).toDouble(),
      saldoUtilizado: (json['saldo_utilizado'] ?? 0).toDouble(),
      fechaCorte: json['fecha_corte']?.toString(),
      fechaPago: json['fecha_pago']?.toString(),
      estado: json['estado']?.toString(),
    );
  }
}

class NotificacionApp {
  final String id;
  final String titulo;
  final String? cuerpo;
  final String? tipo;
  final bool leida;
  final String createdAt;

  NotificacionApp({
    required this.id,
    required this.titulo,
    this.cuerpo,
    this.tipo,
    this.leida = false,
    required this.createdAt,
  });

  factory NotificacionApp.fromApi(Map<String, dynamic> json) {
    return NotificacionApp(
      id: json['id']?.toString() ?? '',
      titulo: json['titulo']?.toString() ?? '',
      cuerpo: json['cuerpo']?.toString(),
      tipo: json['tipo']?.toString(),
      leida: json['leida'] ?? false,
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}

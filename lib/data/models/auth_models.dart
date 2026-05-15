import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String uid;
  final String email;
  final String nombreCompleto;
  final String dni;
  final String telefono;
  final String? fotoUrl;
  final DateTime fechaRegistro;
  final List<String> dispositivosConfianza;
  final double saldoCapital;
  final double interesesAcumulados;
  final String numeroCuenta;

  Usuario({
    required this.uid,
    required this.email,
    required this.nombreCompleto,
    required this.dni,
    required this.telefono,
    this.fotoUrl,
    required this.fechaRegistro,
    this.dispositivosConfianza = const [],
    this.saldoCapital = 0.0,
    this.interesesAcumulados = 0.0,
    this.numeroCuenta = '',
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'nombreCompleto': nombreCompleto,
    'dni': dni,
    'telefono': telefono,
    'fotoUrl': fotoUrl,
    'fechaRegistro': fechaRegistro.toIso8601String(),
    'dispositivosConfianza': dispositivosConfianza,
    'saldoCapital': saldoCapital,
    'interesesAcumulados': interesesAcumulados,
    'numeroCuenta': numeroCuenta,
  };

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      nombreCompleto: json['nombreCompleto'] ?? '',
      dni: json['dni'] ?? '',
      telefono: json['telefono'] ?? '',
      fotoUrl: json['fotoUrl'],
      fechaRegistro: json['fechaRegistro'] != null
          ? (json['fechaRegistro'] is Timestamp
              ? (json['fechaRegistro'] as Timestamp).toDate()
              : DateTime.parse(json['fechaRegistro'].toString()))
          : DateTime.now(),
      dispositivosConfianza: List<String>.from(json['dispositivosConfianza'] ?? []),
      saldoCapital: (json['saldoCapital'] ?? 0.0).toDouble(),
      interesesAcumulados: (json['interesesAcumulados'] ?? 0.0).toDouble(),
      numeroCuenta: json['numeroCuenta'] ?? '',
    );
  }
}
class Usuario {
  final String id;
  final String codCliente;
  final String numeroDocumento;
  final String nombres;
  final String apellidos;
  final String email;
  final String telefono;

  Usuario({
    required this.id,
    this.codCliente = '',
    required this.numeroDocumento,
    required this.nombres,
    required this.apellidos,
    this.email = '',
    this.telefono = '',
  });

  String get nombreCompleto => '$nombres $apellidos';

  Map<String, dynamic> toJson() => {
    'id': id,
    'codCliente': codCliente,
    'numeroDocumento': numeroDocumento,
    'nombres': nombres,
    'apellidos': apellidos,
    'email': email,
    'telefono': telefono,
  };

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id']?.toString() ?? '',
      codCliente: json['cod_cliente']?.toString() ?? '',
      numeroDocumento: json['numero_documento']?.toString() ?? '',
      nombres: json['nombres']?.toString() ?? '',
      apellidos: json['apellidos']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      telefono: json['telefono']?.toString() ?? '',
    );
  }
}

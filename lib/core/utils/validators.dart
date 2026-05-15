import 'package:flutter/material.dart';

class Validators {
  // Validar email
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo electrónico es obligatorio';
    }
    
    // Expresión regular para email válido
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un correo electrónico válido';
    }
    
    return null;
  }

  // Validar contraseña
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es obligatoria';
    }
    
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    
    return null;
  }

  // Validar confirmación de contraseña
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirma tu contraseña';
    }
    
    if (value != password) {
      return 'Las contraseñas no coinciden';
    }
    
    return null;
  }

  // Validar DNI (8 dígitos para Perú)
  static String? dni(String? value) {
    if (value == null || value.isEmpty) {
      return 'El DNI es obligatorio';
    }
    
    final dniRegex = RegExp(r'^\d{8}$');
    
    if (!dniRegex.hasMatch(value)) {
      return 'Ingresa un DNI válido de 8 dígitos';
    }
    
    return null;
  }

  // Validar número de celular (9 dígitos para Perú)
  static String? celular(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de celular es obligatorio';
    }
    
    final celularRegex = RegExp(r'^\d{9}$');
    
    if (!celularRegex.hasMatch(value)) {
      return 'Ingresa un celular válido de 9 dígitos';
    }
    
    return null;
  }

  // Validar monto (para transferencias y pagos)
  static String? monto(String? value, {double min = 0.01, double max = 30000}) {
    if (value == null || value.isEmpty) {
      return 'El monto es obligatorio';
    }
    
    final montoDouble = double.tryParse(value);
    
    if (montoDouble == null) {
      return 'Ingresa un monto válido';
    }
    
    if (montoDouble < min) {
      return 'El monto mínimo es S/ ${min.toStringAsFixed(2)}';
    }
    
    if (montoDouble > max) {
      return 'El monto máximo es S/ ${max.toStringAsFixed(2)}';
    }
    
    return null;
  }

  // Validar número de cuenta (para transferencias)
  static String? numeroCuenta(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de cuenta es obligatorio';
    }
    
    final cuentaRegex = RegExp(r'^\d{10,20}$');
    
    if (!cuentaRegex.hasMatch(value)) {
      return 'Ingresa un número de cuenta válido (10-20 dígitos)';
    }
    
    return null;
  }

  // Validar código de servicio (luz, agua, etc.)
  static String? codigoServicio(String? value) {
    if (value == null || value.isEmpty) {
      return 'El código de servicio es obligatorio';
    }
    
    if (value.length < 5) {
      return 'El código debe tener al menos 5 caracteres';
    }
    
    return null;
  }

  // Validar nombre completo
  static String? nombreCompleto(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre completo es obligatorio';
    }
    
    if (value.length < 3) {
      return 'Ingresa tu nombre completo';
    }
    
    final nombreRegex = RegExp(r'^[a-zA-ZáéíóúñÁÉÍÓÚÑ\s]+$');
    
    if (!nombreRegex.hasMatch(value)) {
      return 'El nombre solo debe contener letras';
    }
    
    return null;
  }

  // Validar que no esté vacío
  static String? required(String? value, {String fieldName = 'Campo'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName es obligatorio';
    }
    return null;
  }

  // Validar que sea numérico
  static String? numeric(String? value, {String fieldName = 'Campo'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName es obligatorio';
    }
    
    if (double.tryParse(value) == null) {
      return '$fieldName debe ser un número válido';
    }
    
    return null;
  }

  // Validar teléfono fijo
  static String? telefonoFijo(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Opcional
    }
    
    final telefonoRegex = RegExp(r'^\d{6,7}$');
    
    if (!telefonoRegex.hasMatch(value)) {
      return 'Ingresa un teléfono válido (6-7 dígitos)';
    }
    
    return null;
  }

  // Validar RUC (11 dígitos para Perú)
  static String? ruc(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Opcional
    }
    
    final rucRegex = RegExp(r'^\d{11}$');
    
    if (!rucRegex.hasMatch(value)) {
      return 'Ingresa un RUC válido de 11 dígitos';
    }
    
    return null;
  }

  // Validar que sea mayor de edad (18 años)
  static String? fechaNacimiento(DateTime? fecha) {
    if (fecha == null) {
      return 'La fecha de nacimiento es obligatoria';
    }
    
    final hoy = DateTime.now();
    final edad = hoy.year - fecha.year;
    final mes = hoy.month - fecha.month;
    final dia = hoy.day - fecha.day;
    
    final edadCalculada = mes < 0 || (mes == 0 && dia < 0) ? edad - 1 : edad;
    
    if (edadCalculada < 18) {
      return 'Debes ser mayor de 18 años';
    }
    
    return null;
  }

  // Validar formato de fecha (DD/MM/AAAA)
  static String? fechaFormat(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Opcional
    }
    
    final fechaRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    
    if (!fechaRegex.hasMatch(value)) {
      return 'Formato de fecha inválido (DD/MM/AAAA)';
    }
    
    // Validar que sea una fecha real
    final partes = value.split('/');
    final dia = int.parse(partes[0]);
    final mes = int.parse(partes[1]);
    final anio = int.parse(partes[2]);
    
    if (mes < 1 || mes > 12) {
      return 'Mes inválido';
    }
    
    if (dia < 1 || dia > 31) {
      return 'Día inválido';
    }
    
    // Validar días por mes
    if (mes == 2) {
      final esBisiesto = (anio % 4 == 0 && anio % 100 != 0) || (anio % 400 == 0);
      if (dia > (esBisiesto ? 29 : 28)) {
        return 'Día inválido para febrero';
      }
    } else if ([4, 6, 9, 11].contains(mes) && dia > 30) {
      return 'Día inválido para este mes';
    }
    
    return null;
  }

  // Validar CVV de tarjeta (3 o 4 dígitos)
  static String? cvv(String? value) {
    if (value == null || value.isEmpty) {
      return 'El CVV es obligatorio';
    }
    
    final cvvRegex = RegExp(r'^\d{3,4}$');
    
    if (!cvvRegex.hasMatch(value)) {
      return 'El CVV debe tener 3 o 4 dígitos';
    }
    
    return null;
  }

  // Validar que el valor esté dentro de un rango
  static String? rangoNumerico(String? value, double min, double max, {String fieldName = 'Valor'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName es obligatorio';
    }
    
    final numero = double.tryParse(value);
    
    if (numero == null) {
      return '$fieldName debe ser un número válido';
    }
    
    if (numero < min) {
      return '$fieldName no puede ser menor a ${min.toStringAsFixed(2)}';
    }
    
    if (numero > max) {
      return '$fieldName no puede ser mayor a ${max.toStringAsFixed(2)}';
    }
    
    return null;
  }

  // Validar placa de vehículo (formato peruano)
  static String? placaVehiculo(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Opcional
    }
    
    // Formato: ABC-123 o ABC123
    final placaRegex = RegExp(r'^[A-Za-z]{3}-?\d{3}$');
    
    if (!placaRegex.hasMatch(value.toUpperCase())) {
      return 'Formato de placa inválido (Ej: ABC-123)';
    }
    
    return null;
  }
}

// Extension para facilitar la validación en formularios
extension FormValidationExtension on GlobalKey<FormState> {
  bool validateAndSave() {
    final form = currentState;
    if (form != null) {
      return form.validate();
    }
    return false;
  }
  
  void resetForm() {
    currentState?.reset();
  }
  
  void clearForm() {
    currentState?.reset();
  }
}

// Mixin para manejar validaciones en ViewModels
mixin FormValidationMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  bool isFormValid() {
    return formKey.currentState?.validate() ?? false;
  }
  
  void saveForm() {
    formKey.currentState?.save();
  }
  
  void resetForm() {
    formKey.currentState?.reset();
  }
}
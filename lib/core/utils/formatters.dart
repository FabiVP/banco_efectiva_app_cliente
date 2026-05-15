import 'package:intl/intl.dart';

class Formatters {
  // Formatear monto a Soles
  static String formatMonto(double monto) {
    final formatter = NumberFormat.currency(
      locale: 'es_PE',
      symbol: 'S/ ',
      decimalDigits: 2,
    );
    return formatter.format(monto);
  }

  // Formatear fecha
  static String formatFecha(DateTime fecha) {
    return DateFormat('dd/MM/yyyy').format(fecha);
  }

  // Formatear fecha y hora
  static String formatFechaHora(DateTime fecha) {
    return DateFormat('dd/MM/yyyy HH:mm').format(fecha);
  }

  // Formatear número de tarjeta (ocultar dígitos)
  static String formatTarjeta(String numero, {bool mostrarCompleto = false}) {
    if (numero.length < 16) return numero;
    
    if (mostrarCompleto) {
      return '${numero.substring(0, 4)} ${numero.substring(4, 8)} ${numero.substring(8, 12)} ${numero.substring(12, 16)}';
    } else {
      return '**** **** **** ${numero.substring(12, 16)}';
    }
  }

  // Formatear DNI
  static String formatDNI(String dni) {
    if (dni.length != 8) return dni;
    return '${dni.substring(0, 4)}-${dni.substring(4, 8)}';
  }

  // Formatear celular
  static String formatCelular(String celular) {
    if (celular.length != 9) return celular;
    return '${celular.substring(0, 3)} ${celular.substring(3, 6)} ${celular.substring(6, 9)}';
  }

  // Formatear número de cuenta
  static String formatNumeroCuenta(String numero) {
    if (numero.length <= 12) return numero;
    return '${numero.substring(0, 4)}-${numero.substring(4, 8)}-${numero.substring(8, 12)}-${numero.substring(12)}';
  }

  // Obtener iniciales de un nombre
  static String getInitials(String nombre) {
    final nombres = nombre.trim().split(' ');
    if (nombres.isEmpty) return 'U';
    
    if (nombres.length == 1) {
      return nombres[0][0].toUpperCase();
    }
    
    return '${nombres[0][0]}${nombres[1][0]}'.toUpperCase();
  }

  // Formatear porcentaje
  static String formatPorcentaje(double valor) {
    return '${(valor * 100).toStringAsFixed(2)}%';
  }

  // Formatear número con separadores de miles
  static String formatNumero(double numero) {
    final formatter = NumberFormat('#,###.##');
    return formatter.format(numero);
  }

  // Truncar texto con elipsis
  static String truncate(String texto, int maxLength) {
    if (texto.length <= maxLength) return texto;
    return '${texto.substring(0, maxLength)}...';
  }
}
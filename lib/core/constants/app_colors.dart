import 'package:flutter/material.dart';

class EfectivaColors {
  // ──────────────────────────────────────────────
  // DESIGN TOKENS — Financiera Efectiva
  // Marca: Confianza · Seguridad · Modernidad
  // Paleta base azul corporativa (compartida)
  // ──────────────────────────────────────────────

  // Azules institucionales
  static const Color azulInstitucional = Color(0xFF0A1E4A);
  static const Color azulCorporativo = Color(0xFF1565F5);
  static const Color azulSecundario = Color(0xFF2563EB);
  static const Color azulClaro = Color(0xFF60A5FA);
  static const Color azulSuave = Color(0xFFE8F0FE);
  static const Color azulFondo = Color(0xFFF0F5FF);

  // Neutros
  static const Color blanco = Color(0xFFFFFFFF);
  static const Color grisFondo = Color(0xFFF5F7FA);
  static const Color grisBorde = Color(0xFFD1D5DB);
  static const Color grisClaro = Color(0xFFE5E7EB);
  static const Color grisMedio = Color(0xFF9CA3AF);
  static const Color grisTexto = Color(0xFF6B7280);
  static const Color negroTexto = Color(0xFF111827);

  // Semánticos — App Cliente (acento verde: pagos, salud financiera)
  static const Color verdeExito = Color(0xFF10B981);
  static const Color verdeSuave = Color(0xFFD1FAE5);
  static const Color rojoError = Color(0xFFEF4444);
  static const Color rojoSuave = Color(0xFFFEE2E2);
  static const Color amberAdvertencia = Color(0xFFF59E0B);
  static const Color amberSuave = Color(0xFFFEF3C7);
  static const Color azulInfo = Color(0xFF3B82F6);
  static const Color azulInfoSuave = Color(0xFFDBEAFE);

  // Estados de solicitud
  static const Color estadoEnviado = Color(0xFF3B82F6);
  static const Color estadoEvaluacion = Color(0xFFF59E0B);
  static const Color estadoAprobado = Color(0xFF10B981);
  static const Color estadoDesembolsado = Color(0xFF0EA5E9);
  static const Color estadoRechazado = Color(0xFFEF4444);

  // Gradientes
  static const LinearGradient gradientePrincipal = LinearGradient(
    colors: [azulInstitucional, azulCorporativo],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradienteHero = LinearGradient(
    colors: [azulInstitucional, Color(0xFF1E3A7A), azulCorporativo],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradienteCard = LinearGradient(
    colors: [Color(0xFF0D2B5A), Color(0xFF1A4FA0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradienteVerde = LinearGradient(
    colors: [verdeExito, Color(0xFF34D399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Aliases de compatibilidad (nombres antiguos) ──
  static const Color azulPrincipal = azulCorporativo;
  static const Color azulOscuro = azulInstitucional;
  static const Color amarilloAcento = amberAdvertencia;
  static const Color amarilloClaro = amberSuave;
  static const Color grisSubtitulo = grisMedio;
  static const Color naranjaAcento = verdeExito;
  static const LinearGradient gradienteHeader = gradienteHero;
  static const LinearGradient gradienteNaranja = gradienteVerde;
  static const LinearGradient gradienteTarjeta = gradienteCard;
}

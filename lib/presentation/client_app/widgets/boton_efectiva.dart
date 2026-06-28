import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class BotonEfectiva extends StatelessWidget {
  final String texto;
  final IconData? icono;
  final VoidCallback onPressed;
  final Color? color;
  final bool expandido;
  final double alto;
  final bool cargando;

  const BotonEfectiva({
    super.key,
    required this.texto,
    this.icono,
    required this.onPressed,
    this.color,
    this.expandido = true,
    this.alto = 52,
    this.cargando = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color colorFinal = color ?? EfectivaColors.azulPrincipal;

    return SizedBox(
      width: expandido ? double.infinity : null,
      height: alto,
      child: ElevatedButton(
        onPressed: cargando ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorFinal,
          disabledBackgroundColor: colorFinal.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 2,
          shadowColor: colorFinal.withValues(alpha: 0.3),
        ),
        child: cargando
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icono != null) ...[
                    Icon(icono, size: 20, color: Colors.white),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    texto,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

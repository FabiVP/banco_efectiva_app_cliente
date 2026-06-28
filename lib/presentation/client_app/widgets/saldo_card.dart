import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class SaldoCard extends StatefulWidget {
  final double saldo;
  final double intereses;
  final String numeroCuenta;

  const SaldoCard({
    super.key,
    required this.saldo,
    required this.intereses,
    required this.numeroCuenta,
  });

  @override
  State<SaldoCard> createState() => _SaldoCardState();
}

class _SaldoCardState extends State<SaldoCard> {
  bool _mostrarSaldo = true;
  bool _esFavorito = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con cuenta digital e iconos
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: EfectivaColors.azulSuave,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  size: 20,
                  color: EfectivaColors.azulPrincipal,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cuenta Digital',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: EfectivaColors.negroTexto,
                    ),
                  ),
                  Text(
                    widget.numeroCuenta,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: EfectivaColors.grisSubtitulo,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Favorito
              IconButton(
                icon: Icon(
                  _esFavorito ? Icons.star_rounded : Icons.star_border_rounded,
                  color: EfectivaColors.amarilloAcento, size: 22,
                ),
                onPressed: () {
                  setState(() => _esFavorito = !_esFavorito);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _esFavorito ? '⭐ Añadido a favoritos' : 'Eliminado de favoritos',
                        style: GoogleFonts.inter(),
                      ),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 8),
              // Visibilidad
              IconButton(
                icon: Icon(
                  _mostrarSaldo
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: EfectivaColors.azulPrincipal,
                  size: 22,
                ),
                onPressed: () =>
                    setState(() => _mostrarSaldo = !_mostrarSaldo),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Saldo
          Text(
            'Saldo capital',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: EfectivaColors.grisTexto,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _mostrarSaldo
                ? Text(
                    'S/ ${widget.saldo.toStringAsFixed(2)}',
                    key: const ValueKey('visible'),
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: EfectivaColors.negroTexto,
                      letterSpacing: -0.5,
                    ),
                  )
                : Text(
                    'S/ ••••••',
                    key: const ValueKey('hidden'),
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: EfectivaColors.negroTexto,
                      letterSpacing: 2,
                    ),
                  ),
          ),
          const SizedBox(height: 12),

          // Intereses
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: EfectivaColors.verdeSuave,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.trending_up_rounded,
                  size: 16,
                  color: EfectivaColors.verdeExito,
                ),
                const SizedBox(width: 6),
                Text(
                  'Intereses del mes: S/ ${widget.intereses.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: EfectivaColors.verdeExito,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Botones de acción
          Row(
            children: [
              Expanded(
                child: _buildAccionBoton(
                  Icons.edit_outlined,
                  'Editar favorito',
                  EfectivaColors.azulPrincipal,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildAccionBoton(
                  Icons.remove_red_eye_outlined,
                  'Mostrar datos',
                  EfectivaColors.naranjaAcento,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccionBoton(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
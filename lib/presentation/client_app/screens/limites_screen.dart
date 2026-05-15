import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class LimitesScreen extends StatefulWidget {
  const LimitesScreen({super.key});

  @override
  State<LimitesScreen> createState() => _LimitesScreenState();
}

class _LimitesScreenState extends State<LimitesScreen> {
  final Map<String, double> _limites = {
    'yapea_plin': 500.00,
    'transferencias_efectiva': 30000.00,
    'transferencias_otros': 30000.00,
    'pago_servicios': 2500.00,
    'pago_tarjetas': 2500.00,
    'tarjeta_debito': 5000.00,
  };

  final Map<String, double> _usados = {
    'yapea_plin': 150.00,
    'transferencias_efectiva': 500.00,
    'transferencias_otros': 0.00,
    'pago_servicios': 85.00,
    'pago_tarjetas': 0.00,
    'tarjeta_debito': 320.00,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EfectivaColors.grisFondo,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: EfectivaColors.gradienteHeader,
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new,
                                color: Colors.white, size: 20),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            'Gestión de límites de transferencias',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildLimiteCard(
                  'Yapea o Plinéa',
                  'Pago a contacto',
                  _limites['yapea_plin']!,
                  _usados['yapea_plin']!,
                  Icons.qr_code_rounded,
                  EfectivaColors.verdeExito,
                  'yapea_plin',
                ),
                const SizedBox(height: 12),
                _buildLimiteCard(
                  'Transferencias',
                  'Otras cuentas Efectiva',
                  _limites['transferencias_efectiva']!,
                  _usados['transferencias_efectiva']!,
                  Icons.swap_horiz_rounded,
                  EfectivaColors.azulPrincipal,
                  'transferencias_efectiva',
                ),
                const SizedBox(height: 12),
                _buildLimiteCard(
                  'Transferencias',
                  'Otras cuentas bancos locales',
                  _limites['transferencias_otros']!,
                  _usados['transferencias_otros']!,
                  Icons.account_balance_rounded,
                  EfectivaColors.azulPrincipal,
                  'transferencias_otros',
                ),
                const SizedBox(height: 12),
                _buildLimiteCard(
                  'Pago de Servicios',
                  'Servicios e instituciones',
                  _limites['pago_servicios']!,
                  _usados['pago_servicios']!,
                  Icons.receipt_long_rounded,
                  EfectivaColors.naranjaAcento,
                  'pago_servicios',
                ),
                const SizedBox(height: 12),
                _buildLimiteCard(
                  'Pago de tarjeta de crédito',
                  'Pago de tarjeta de crédito de otros bancos',
                  _limites['pago_tarjetas']!,
                  _usados['pago_tarjetas']!,
                  Icons.credit_card_rounded,
                  const Color(0xFF7C3AED),
                  'pago_tarjetas',
                ),
                const SizedBox(height: 12),
                _buildLimiteCard(
                  'Tarjeta de Débito Digital',
                  'Compras con Tarjeta de Débito Digital',
                  _limites['tarjeta_debito']!,
                  _usados['tarjeta_debito']!,
                  Icons.credit_score_rounded,
                  const Color(0xFFE91E63),
                  'tarjeta_debito',
                ),
                const SizedBox(height: 24),
                // Botón editar
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Los límites se actualizan desde la app o en agencia',
                          style: GoogleFonts.inter(),
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_rounded),
                  label: const Text('Editar'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLimiteCard(
    String titulo,
    String subtitulo,
    double limite,
    double usado,
    IconData icon,
    Color color,
    String key,
  ) {
    final progreso = limite > 0 ? usado / limite : 0.0;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: EfectivaColors.negroTexto,
                      ),
                    ),
                    Text(
                      subtitulo,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: EfectivaColors.grisSubtitulo,
                      ),
                    ),
                  ],
                ),
              ),
              // Toggle
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: EfectivaColors.grisClaro,
                    width: 2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Límite diario',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: EfectivaColors.grisTexto,
                ),
              ),
              Text(
                'S/ ${limite.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: EfectivaColors.negroTexto,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progreso,
              backgroundColor: EfectivaColors.grisClaro,
              color: progreso < 0.7
                  ? color
                  : progreso < 0.9
                      ? EfectivaColors.naranjaAcento
                      : EfectivaColors.rojoError,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Usado hoy: S/ ${usado.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: EfectivaColors.grisSubtitulo,
            ),
          ),
        ],
      ),
    );
  }
}
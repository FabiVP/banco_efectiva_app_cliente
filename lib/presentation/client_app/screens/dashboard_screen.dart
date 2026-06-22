import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/saldo_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeVM = context.watch<HomeViewModel>();
    final authVM = context.watch<AuthViewModel>();

    final cuenta = homeVM.cuentas.isNotEmpty ? homeVM.cuentas.first : null;
    final movimientos = homeVM.movimientos;

    return Scaffold(
      backgroundColor: EfectivaColors.grisFondo,
      body: homeVM.state == HomeState.loading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
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
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'E',
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.misProductos,
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '¡Hola, ${authVM.usuarioActual?.nombreCompleto ?? 'bienvenido'}!',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          _buildHeaderButton(Icons.notifications_none_rounded,
                              context),
                          const SizedBox(width: 8),
                          _buildHeaderButton(
                              Icons.qr_code_scanner_rounded, context),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          _buildProductTab('Ver productos', true),
                          const SizedBox(width: 8),
                          _buildProductTab('Tarjeta Débito Digital Visa', false),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SaldoCard(
                      saldo: cuenta?.saldoCapital ?? 0,
                      intereses: cuenta?.saldoInteres ?? 0,
                      numeroCuenta: cuenta?.codCuentaAhorro ?? '---',
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          // Acciones rápidas (Grid de productos)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Acciones rápidas',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: EfectivaColors.negroTexto,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildListDelegate([
                _buildQuickAction(
                  context,
                  Icons.swap_horiz_rounded,
                  'Transferencias',
                  EfectivaColors.azulPrincipal,
                  () => Navigator.pushNamed(context, '/transferencias'),
                ),
                _buildQuickAction(
                  context,
                  Icons.credit_card_rounded,
                  'Tarjeta Débito',
                  const Color(0xFF7C3AED),
                  () => Navigator.pushNamed(context, '/tarjeta'),
                ),
                _buildQuickAction(
                  context,
                  Icons.receipt_long_rounded,
                  'Pagar servicios',
                  EfectivaColors.naranjaAcento,
                  () => Navigator.pushNamed(context, '/pagos'),
                ),
                _buildQuickAction(
                  context,
                  Icons.savings_rounded,
                  'Ahorros',
                  EfectivaColors.verdeExito,
                  () => Navigator.pushNamed(context, '/ahorros'),
                ),
                _buildQuickAction(
                  context,
                  Icons.account_balance_rounded,
                  'Créditos',
                  const Color(0xFFE91E63),
                  () => Navigator.pushNamed(context, '/creditos'),
                ),
                _buildQuickAction(
                  context,
                  Icons.tune_rounded,
                  'Límites',
                  const Color(0xFF00BCD4),
                  () => Navigator.pushNamed(context, '/limites'),
                ),
              ]),
            ),
          ),

          // Banner préstamo
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildPrestamosBanner(context),
            ),
          ),

          // Últimos movimientos
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Últimos movimientos',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: EfectivaColors.negroTexto,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Ver todo',
                      style: GoogleFonts.inter(
                        color: EfectivaColors.azulPrincipal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ...movimientos.map((m) => _buildMovimiento(
                  m.concepto ?? 'Movimiento',
                  m.codOperacion,
                  '${m.esIngreso ? '+' : '-'}S/ ${m.monto.toStringAsFixed(2)}',
                  _formatFecha(m.fechaOperacion),
                  m.esIngreso
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  m.esIngreso
                      ? EfectivaColors.verdeExito
                      : Colors.red,
                )),
                const SizedBox(height: 20),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon, BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20),
        padding: EdgeInsets.zero,
        onPressed: () {},
      ),
    );
  }

  Widget _buildProductTab(String text, bool active) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: active
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: active
              ? Border.all(color: Colors.white30)
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              color: active ? Colors.white : Colors.white60,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.15),
                    color.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: EfectivaColors.negroTexto,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrestamosBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/creditos'),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: EfectivaColors.gradienteNaranja,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: EfectivaColors.naranjaAcento.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '⚡ Préstamo al instante',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Solicítalo aquí,\nfácil y rápido',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovimiento(String titulo, String subtitulo, String monto,
      String fecha, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
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
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: EfectivaColors.negroTexto,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitulo,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: EfectivaColors.grisTexto,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                monto,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: monto.startsWith('+')
                      ? EfectivaColors.verdeExito
                      : EfectivaColors.negroTexto,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                fecha,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: EfectivaColors.grisSubtitulo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatFecha(String raw) {
    try {
      final dt = DateTime.parse(raw);
      final now = DateTime.now();
      final diff = now.difference(dt);
      if (diff.inDays == 0) return 'Hoy, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      if (diff.inDays == 1) return 'Ayer, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      return '${dt.day} ${_mes(dt.month)}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return raw;
    }
  }

  String _mes(int m) {
    const meses = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Set', 'Oct', 'Nov', 'Dic'];
    return meses[m - 1];
  }
}
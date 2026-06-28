import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import 'dashboard_screen.dart';
import 'pagos_screen.dart';
import 'perfil_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    PagosScreen(),
    _PromocionesTab(),
    PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.widgets_outlined, Icons.widgets,
                    'PRODUCTOS'),
                _buildNavItem(
                    1, Icons.payment_outlined, Icons.payment, 'PAGAR'),
                _buildNavItem(2, Icons.local_offer_outlined,
                    Icons.local_offer, 'PARA TI'),
                _buildNavItem(3, Icons.person_outline, Icons.person,
                    'MI CUENTA'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? EfectivaColors.azulPrincipal.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 24,
              color: isSelected
                  ? EfectivaColors.azulPrincipal
                  : EfectivaColors.grisSubtitulo,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? EfectivaColors.azulPrincipal
                    : EfectivaColors.grisSubtitulo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Tab de "Para ti" — Promociones
class _PromocionesTab extends StatelessWidget {
  const _PromocionesTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EfectivaColors.grisFondo,
      appBar: AppBar(
        title: const Text('Para ti'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPromoCard(
            'Préstamo al instante',
            'Solicítalo aquí, fácil y rápido.\nHasta S/ 50,000 a tasas preferenciales.',
            Icons.flash_on,
            EfectivaColors.naranjaAcento,
            () => Navigator.pushNamed(context, '/creditos'),
          ),
          _buildPromoCard(
            'Cuenta de Ahorro Premium',
            'Gana hasta 8% de interés anual.\nAbre tu cuenta 100% digital.',
            Icons.savings,
            EfectivaColors.verdeExito,
            () => Navigator.pushNamed(context, '/ahorros'),
          ),
          _buildPromoCard(
            'Tarjeta VISA Digital',
            'Compras seguras en línea.\nSin costo de mantenimiento.',
            Icons.credit_card,
            EfectivaColors.azulPrincipal,
            () => Navigator.pushNamed(context, '/tarjeta'),
          ),
          _buildPromoCard(
            'Seguro de vida',
            'Protege a los tuyos desde S/ 5/mes.\nCobertura hasta S/ 100,000.',
            Icons.shield_outlined,
            const Color(0xFF7C3AED),
            () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  title: const Text('Seguro de vida'),
                  content: const Text('Comunícate con tu asesor para contratar el seguro de vida.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCard(
      String title, String description, IconData icon, Color color, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withValues(alpha: 0.2),
                          color.withValues(alpha: 0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, color: color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: EfectivaColors.negroTexto,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: EfectivaColors.grisTexto,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: color.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

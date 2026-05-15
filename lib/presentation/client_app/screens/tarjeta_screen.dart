import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class TarjetaScreen extends StatefulWidget {
  const TarjetaScreen({super.key});

  @override
  State<TarjetaScreen> createState() => _TarjetaScreenState();
}

class _TarjetaScreenState extends State<TarjetaScreen>
    with SingleTickerProviderStateMixin {
  bool _mostrarDatos = false;
  bool _tarjetaActiva = true;
  late AnimationController _flipController;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

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
                    // App bar
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tarjeta de Débito Digital',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'VISA',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Tarjeta VISA
                    _buildTarjetaVisa(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Toggle mostrar datos
                  _buildOptionCard(
                    icon: Icons.visibility_rounded,
                    iconColor: EfectivaColors.azulPrincipal,
                    title: 'Mostrar datos',
                    subtitle: 'Ver número completo y CVV',
                    trailing: Switch(
                      value: _mostrarDatos,
                      onChanged: (value) {
                        setState(() => _mostrarDatos = value);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Personalizar
                  _buildOptionCard(
                    icon: Icons.palette_rounded,
                    iconColor: EfectivaColors.naranjaAcento,
                    title: 'Personaliza tu tarjeta',
                    subtitle: 'Elige un diseño único',
                    trailing: const Icon(Icons.chevron_right,
                        color: EfectivaColors.grisSubtitulo),
                    onTap: _personalizarTarjeta,
                  ),
                  const SizedBox(height: 10),

                  // Configuraciones
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                          child: Text(
                            'Configuración de tarjeta',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: EfectivaColors.negroTexto,
                            ),
                          ),
                        ),
                        _buildSettingTile(
                          Icons.payment_rounded,
                          'Google Pay',
                          'Agrega tu tarjeta a la billetera',
                          EfectivaColors.azulPrincipal,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Tarjeta agregada a Google Pay',
                                  style: GoogleFonts.inter(),
                                ),
                                backgroundColor: EfectivaColors.verdeExito,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          },
                        ),
                        const Divider(indent: 68),
                        _buildSettingRow(
                          'Nombre del producto',
                          'Tarjeta Débito Digital',
                        ),
                        _buildSettingRow('Moneda', 'Soles'),
                        const Divider(indent: 20, endIndent: 20),
                        // Apagar tarjeta
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: (_tarjetaActiva
                                        ? EfectivaColors.verdeExito
                                        : EfectivaColors.rojoError)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.power_settings_new_rounded,
                                color: _tarjetaActiva
                                    ? EfectivaColors.verdeExito
                                    : EfectivaColors.rojoError,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              'Apagar tarjeta',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              _tarjetaActiva
                                  ? 'Tu tarjeta está activa'
                                  : 'Se deshabilitará hasta que la habilites',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: EfectivaColors.grisSubtitulo,
                              ),
                            ),
                            trailing: Switch(
                              value: !_tarjetaActiva,
                              onChanged: (value) {
                                setState(() => _tarjetaActiva = !value);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      !value
                                          ? 'Tarjeta activada'
                                          : 'Tarjeta apagada',
                                      style: GoogleFonts.inter(),
                                    ),
                                    backgroundColor: !value
                                        ? EfectivaColors.verdeExito
                                        : EfectivaColors.rojoError,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Seguridad info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: EfectivaColors.azulSuave,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.security_rounded,
                            color: EfectivaColors.azulPrincipal),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Tu tarjeta es segura para pagos e-commerce, QR y Google Pay',
                            style: GoogleFonts.inter(
                              color: EfectivaColors.azulPrincipal,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTarjetaVisa() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 210,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D2B5A), Color(0xFF1A4FA0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: -40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.03),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header: Efectiva + VISA
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Efectiva',
                      style: GoogleFonts.pacifico(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'VISA',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 3,
                          ),
                        ),
                        Text(
                          'Débito',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: Colors.white60,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Card number
                Text(
                  _mostrarDatos
                      ? '4397  ****  ****  1234'
                      : '****  ****  ****  4397',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                // CVV + Expiry
                Row(
                  children: [
                    _buildCardDetail(
                        'CVV', _mostrarDatos ? '123' : '***'),
                    const SizedBox(width: 32),
                    _buildCardDetail(
                        'Válido hasta', _mostrarDatos ? '12/28' : '**/**'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white54,
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: EfectivaColors.grisSubtitulo,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  Widget _buildSettingTile(
      IconData icon, String title, String subtitle, Color color,
      {VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: EfectivaColors.grisSubtitulo,
        ),
      ),
      trailing: const Icon(Icons.chevron_right,
          color: EfectivaColors.grisSubtitulo, size: 20),
      onTap: onTap,
    );
  }

  Widget _buildSettingRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: EfectivaColors.grisTexto,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: EfectivaColors.negroTexto,
            ),
          ),
        ],
      ),
    );
  }

  void _personalizarTarjeta() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Personaliza tu tarjeta',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Elige un color:',
              style: GoogleFonts.inter(color: EfectivaColors.grisTexto),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _colorOption(const Color(0xFF0D2B5A)),
                _colorOption(const Color(0xFF1A1A2E)),
                _colorOption(const Color(0xFF7C3AED)),
                _colorOption(const Color(0xFF059669)),
                _colorOption(const Color(0xFFDC2626)),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  Widget _colorOption(Color color) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }
}
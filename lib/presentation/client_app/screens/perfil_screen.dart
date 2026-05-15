import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../viewmodels/auth_viewmodel.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final usuario = authViewModel.usuarioActual;

    return Scaffold(
      backgroundColor: EfectivaColors.grisFondo,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: EfectivaColors.gradienteHeader,
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  child: Column(
                    children: [
                      // Title
                      Row(
                        children: [
                          Text(
                            'Mi Cuenta',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.settings_outlined,
                                color: Colors.white70, size: 22),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Avatar + info
                      Row(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white30, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                _getInitials(
                                    usuario?.nombreCompleto ?? 'CE'),
                                style: GoogleFonts.inter(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  usuario?.nombreCompleto ??
                                      'Cliente Efectiva',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  usuario?.email ??
                                      'cliente@efectiva.com',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: Colors.white60,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Cliente Premium',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: EfectivaColors.amarilloAcento,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Opciones
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Sección principal
                  _buildSection('Cuenta', [
                    _buildOption(
                      Icons.person_outline_rounded,
                      'Datos personales',
                      'Nombre, DNI, teléfono',
                      EfectivaColors.azulPrincipal,
                      () => _editarDatos(context),
                    ),
                    _buildOption(
                      Icons.phone_android_rounded,
                      'Dispositivos confiados',
                      '2 dispositivos vinculados',
                      const Color(0xFF7C3AED),
                      () => _verDispositivos(context),
                    ),
                    _buildOption(
                      Icons.tune_rounded,
                      'Gestión de límites',
                      'Configura tus límites',
                      EfectivaColors.naranjaAcento,
                      () => Navigator.pushNamed(context, '/limites'),
                    ),
                  ]),
                  const SizedBox(height: 16),

                  // Seguridad
                  _buildSection('Seguridad', [
                    _buildOption(
                      Icons.shield_outlined,
                      'Seguridad',
                      'Contraseña, biometría',
                      EfectivaColors.verdeExito,
                      () => _configurarSeguridad(context),
                    ),
                    _buildOption(
                      Icons.notifications_none_rounded,
                      'Notificaciones',
                      'Push, alertas, promociones',
                      const Color(0xFFE91E63),
                      () => _configurarNotificaciones(context),
                    ),
                  ]),
                  const SizedBox(height: 16),

                  // Otros
                  _buildSection('Otros', [
                    _buildOption(
                      Icons.language_rounded,
                      'Idioma',
                      'Español',
                      const Color(0xFF00BCD4),
                      () => _cambiarIdioma(context),
                    ),
                    _buildOption(
                      Icons.help_outline_rounded,
                      'Centro de ayuda',
                      'FAQ, soporte',
                      EfectivaColors.azulPrincipal,
                      () => _ayuda(context),
                    ),
                    _buildOption(
                      Icons.info_outline_rounded,
                      'Acerca de',
                      'Versión ${AppStrings.version}',
                      EfectivaColors.grisTexto,
                      () => _acercaDe(context),
                    ),
                  ]),
                  const SizedBox(height: 16),

                  // Cerrar sesión
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () => _cerrarSesion(context),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.logout_rounded,
                                  color: EfectivaColors.rojoError,
                                  size: 22),
                              const SizedBox(width: 10),
                              Text(
                                'Cerrar sesión',
                                style: GoogleFonts.inter(
                                  color: EfectivaColors.rojoError,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Version
                  Text(
                    AppStrings.copyright,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: EfectivaColors.grisSubtitulo,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: EfectivaColors.grisTexto,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: List.generate(children.length * 2 - 1, (index) {
              if (index.isOdd) {
                return const Divider(height: 0, indent: 68);
              }
              return children[index ~/ 2];
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildOption(IconData icon, String title, String subtitle,
      Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
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
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: EfectivaColors.negroTexto,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: EfectivaColors.grisSubtitulo,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: EfectivaColors.grisSubtitulo, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  void _editarDatos(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            24, 24, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: EfectivaColors.grisClaro,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Editar datos personales',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nombre completo',
                prefixIcon: Icon(Icons.person_outline,
                    color: EfectivaColors.azulPrincipal),
              ),
            ),
            const SizedBox(height: 14),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Teléfono',
                prefixIcon: Icon(Icons.phone_outlined,
                    color: EfectivaColors.azulPrincipal),
              ),
            ),
            const SizedBox(height: 14),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Dirección',
                prefixIcon: Icon(Icons.location_on_outlined,
                    color: EfectivaColors.azulPrincipal),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Datos actualizados',
                          style: GoogleFonts.inter()),
                      backgroundColor: EfectivaColors.verdeExito,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                child: const Text('Guardar cambios'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _verDispositivos(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: EfectivaColors.grisClaro,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Dispositivos confiados',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            _buildDeviceTile(
              Icons.phone_android_rounded,
              'Samsung Galaxy S23',
              'Último acceso: Hoy, 14:30',
              true,
            ),
            const SizedBox(height: 10),
            _buildDeviceTile(
              Icons.laptop_rounded,
              'MacBook Pro',
              'Último acceso: Hace 3 días',
              false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceTile(
      IconData icon, String name, String lastAccess, bool active) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: EfectivaColors.grisFondo,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: EfectivaColors.azulSuave,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon,
                color: EfectivaColors.azulPrincipal, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  lastAccess,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: EfectivaColors.grisSubtitulo,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active
                  ? EfectivaColors.verdeExito
                  : EfectivaColors.grisSubtitulo,
            ),
          ),
        ],
      ),
    );
  }

  void _configurarNotificaciones(BuildContext context) {
    bool pushEnabled = true;
    bool alertasEnabled = true;
    bool promosEnabled = false;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: EfectivaColors.grisClaro,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Notificaciones',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: Text('Notificaciones push',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                value: pushEnabled,
                onChanged: (v) => setState(() => pushEnabled = v),
              ),
              SwitchListTile(
                title: Text('Alertas de movimientos',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                value: alertasEnabled,
                onChanged: (v) => setState(() => alertasEnabled = v),
              ),
              SwitchListTile(
                title: Text('Promociones',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                value: promosEnabled,
                onChanged: (v) => setState(() => promosEnabled = v),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _configurarSeguridad(BuildContext context) {
    Navigator.pushNamed(context, '/limites');
  }

  void _cambiarIdioma(BuildContext context) {
    String selected = 'es';
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: EfectivaColors.grisClaro,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Seleccionar idioma',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text('Español',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                leading: Icon(
                  selected == 'es'
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: selected == 'es'
                      ? EfectivaColors.azulPrincipal
                      : EfectivaColors.grisSubtitulo,
                ),
                onTap: () {
                  setState(() => selected = 'es');
                  Future.delayed(
                      const Duration(milliseconds: 500),
                      () { if (ctx.mounted) Navigator.pop(ctx); });
                },
              ),
              ListTile(
                title: Text('English',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                leading: Icon(
                  selected == 'en'
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: selected == 'en'
                      ? EfectivaColors.azulPrincipal
                      : EfectivaColors.grisSubtitulo,
                ),
                onTap: () {
                  setState(() => selected = 'en');
                  Future.delayed(
                      const Duration(milliseconds: 500),
                      () { if (ctx.mounted) Navigator.pop(ctx); });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _ayuda(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Comunícate al ${AppStrings.telefonoAtencion}',
          style: GoogleFonts.inter(),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _acercaDe(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: EfectivaColors.azulSuave,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'E',
                  style: GoogleFonts.inter(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: EfectivaColors.azulPrincipal,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Efectiva',
              style: GoogleFonts.pacifico(
                fontSize: 28,
                color: EfectivaColors.azulPrincipal,
              ),
            ),
            Text(
              AppStrings.slogan,
              style: GoogleFonts.inter(
                color: EfectivaColors.grisTexto,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Versión ${AppStrings.version}',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.copyright,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: EfectivaColors.grisSubtitulo,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _cerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Cerrar sesión',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        content: Text(
          '¿Estás seguro de que quieres cerrar sesión?',
          style: GoogleFonts.inter(color: EfectivaColors.grisTexto),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await context.read<AuthViewModel>().logout();
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: EfectivaColors.rojoError,
            ),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
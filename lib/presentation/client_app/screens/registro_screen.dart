import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../viewmodels/auth_viewmodel.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _dniController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _aceptaTerminos = false;
  int _pasoActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: EfectivaColors.gradientePrincipal,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom app bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 20),
                    ),
                    const Spacer(),
                    Text(
                      'Paso ${_pasoActual + 1} de 2',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              // Progress bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (_pasoActual + 1) / 2,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                    minHeight: 4,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _pasoActual == 0
                          ? 'Crea tu cuenta'
                          : 'Datos de seguridad',
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _pasoActual == 0
                          ? 'Ingresa tus datos personales'
                          : 'Establece tu contraseña',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Form
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _pasoActual == 0
                            ? _buildPaso1()
                            : _buildPaso2(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaso1() {
    return Column(
      key: const ValueKey('paso1'),
      children: [
        TextFormField(
          controller: _nombreController,
          decoration: const InputDecoration(
            labelText: 'Nombre completo',
            prefixIcon:
                Icon(Icons.person_outline, color: EfectivaColors.azulPrincipal),
          ),
          validator: Validators.nombreCompleto,
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _dniController,
          decoration: const InputDecoration(
            labelText: 'DNI',
            prefixIcon: Icon(Icons.badge_outlined,
                color: EfectivaColors.azulPrincipal),
          ),
          keyboardType: TextInputType.number,
          maxLength: 8,
          validator: Validators.dni,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _telefonoController,
          decoration: const InputDecoration(
            labelText: 'Celular',
            prefixIcon: Icon(Icons.phone_android_outlined,
                color: EfectivaColors.azulPrincipal),
            prefixText: '+51 ',
          ),
          keyboardType: TextInputType.phone,
          maxLength: 9,
          validator: Validators.celular,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Correo electrónico',
            prefixIcon: Icon(Icons.email_outlined,
                color: EfectivaColors.azulPrincipal),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: Validators.email,
        ),
        const SizedBox(height: 32),
        _buildGradientButton(
          text: 'Continuar',
          onTap: () {
            if (_formKey.currentState!.validate()) {
              setState(() => _pasoActual = 1);
            }
          },
        ),
      ],
    );
  }

  Widget _buildPaso2() {
    return Column(
      key: const ValueKey('paso2'),
      children: [
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            prefixIcon: const Icon(Icons.lock_outline,
                color: EfectivaColors.azulPrincipal),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: EfectivaColors.grisSubtitulo,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          obscureText: _obscurePassword,
          validator: Validators.password,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(
            labelText: 'Confirmar contraseña',
            prefixIcon: const Icon(Icons.lock_outline,
                color: EfectivaColors.azulPrincipal),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirm
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: EfectivaColors.grisSubtitulo,
              ),
              onPressed: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
            ),
          ),
          obscureText: _obscureConfirm,
          validator: (v) =>
              Validators.confirmPassword(v, _passwordController.text),
        ),
        const SizedBox(height: 20),
        // Indicadores de seguridad
        _buildPasswordStrength(),
        const SizedBox(height: 20),
        // Términos y condiciones
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: _aceptaTerminos,
                onChanged: (v) =>
                    setState(() => _aceptaTerminos = v ?? false),
                activeColor: EfectivaColors.azulPrincipal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: 'Acepto los ',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: EfectivaColors.grisTexto,
                  ),
                  children: [
                    TextSpan(
                      text: 'Términos y Condiciones',
                      style: GoogleFonts.inter(
                        color: EfectivaColors.azulPrincipal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(text: ' y la '),
                    TextSpan(
                      text: 'Política de Privacidad',
                      style: GoogleFonts.inter(
                        color: EfectivaColors.azulPrincipal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _pasoActual = 0),
                child: const Text('Atrás'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: _buildGradientButton(
                text: 'Crear cuenta',
                onTap: _aceptaTerminos ? _handleRegistro : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordStrength() {
    final password = _passwordController.text;
    final hasMinLength = password.length >= 6;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EfectivaColors.azulSuave,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seguridad de contraseña',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: EfectivaColors.azulPrincipal,
            ),
          ),
          const SizedBox(height: 8),
          _buildRequisito('Mínimo 6 caracteres', hasMinLength),
          _buildRequisito('Una letra mayúscula', hasUppercase),
          _buildRequisito('Un número', hasNumber),
        ],
      ),
    );
  }

  Widget _buildRequisito(String texto, bool cumple) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            cumple ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: cumple
                ? EfectivaColors.verdeExito
                : EfectivaColors.grisSubtitulo,
          ),
          const SizedBox(width: 8),
          Text(
            texto,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: cumple
                  ? EfectivaColors.verdeExito
                  : EfectivaColors.grisTexto,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton(
      {required String text, VoidCallback? onTap}) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        gradient: onTap != null
            ? EfectivaColors.gradientePrincipal
            : null,
        color: onTap == null ? EfectivaColors.grisClaro : null,
        borderRadius: BorderRadius.circular(14),
        boxShadow: onTap != null
            ? [
                BoxShadow(
                  color:
                      EfectivaColors.azulPrincipal.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: onTap != null
                    ? Colors.white
                    : EfectivaColors.grisSubtitulo,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegistro() async {
    if (!_formKey.currentState!.validate() || !_aceptaTerminos) return;

    final nombreCompleto = _nombreController.text.trim();
    final espacio = nombreCompleto.indexOf(' ');
    final nombres = espacio == -1 ? nombreCompleto : nombreCompleto.substring(0, espacio);
    final apellidos = espacio == -1 ? '' : nombreCompleto.substring(espacio + 1).trim();

    final viewModel = context.read<AuthViewModel>();
    final success = await viewModel.register(
      dni: _dniController.text.trim(),
      nombres: nombres,
      apellidos: apellidos,
      telefono: _telefonoController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '¡Cuenta creada exitosamente!',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: EfectivaColors.verdeExito,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      Navigator.pushReplacementNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            viewModel.errorMessage.isNotEmpty
                ? viewModel.errorMessage
                : 'Error al crear la cuenta',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _dniController.dispose();
    _telefonoController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

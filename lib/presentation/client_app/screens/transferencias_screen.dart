import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/formatters.dart';

class TransferenciasScreen extends StatefulWidget {
  const TransferenciasScreen({super.key});

  @override
  State<TransferenciasScreen> createState() => _TransferenciasScreenState();
}

class _TransferenciasScreenState extends State<TransferenciasScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _montoController = TextEditingController();
  final _celularController = TextEditingController();
  String _metodoSeleccionado = 'yapea';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EfectivaColors.grisFondo,
      body: Column(
        children: [
          // Header con gradient
          Container(
            decoration: const BoxDecoration(
              gradient: EfectivaColors.gradienteHeader,
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          'Transferencias',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      labelColor: EfectivaColors.azulPrincipal,
                      unselectedLabelColor: Colors.white70,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs: const [
                        Tab(text: 'Yapea / Plin'),
                        Tab(text: 'Otras cuentas'),
                        Tab(text: 'Historial'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildYapeaPlinContent(),
                _buildOtrasCuentasContent(),
                _buildHistorialContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYapeaPlinContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Selector
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildMetodoOption(
                    'Yapea',
                    'yapea',
                    Icons.qr_code_rounded,
                    EfectivaColors.verdeExito,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: _buildMetodoOption(
                    'Plinéa',
                    'plin',
                    Icons.bolt_rounded,
                    const Color(0xFF6C63FF),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Celular
          TextField(
            controller: _celularController,
            decoration: InputDecoration(
              labelText: 'Número de celular',
              hintText: '999 888 777',
              prefixIcon: const Icon(Icons.phone_android_outlined,
                  color: EfectivaColors.azulPrincipal),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 14),
          // Monto
          TextField(
            controller: _montoController,
            decoration: InputDecoration(
              labelText: 'Monto a transferir',
              prefixText: 'S/ ',
              prefixIcon: const Icon(Icons.attach_money_rounded,
                  color: EfectivaColors.azulPrincipal),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 14),
          // Límite
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: EfectivaColors.amarilloClaro,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded,
                    color: EfectivaColors.naranjaAcento, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Límite diario disponible: S/ 500.00',
                    style: GoogleFonts.inter(
                      color: EfectivaColors.naranjaAcento,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Botón
          Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              gradient: _metodoSeleccionado == 'yapea'
                  ? const LinearGradient(
                      colors: [Color(0xFF00A859), Color(0xFF00C76B)])
                  : const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)]),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: (_metodoSeleccionado == 'yapea'
                          ? EfectivaColors.verdeExito
                          : const Color(0xFF6C63FF))
                      .withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: _realizarTransferencia,
                child: Center(
                  child: Text(
                    'Transferir al toque',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetodoOption(
      String nombre, String valor, IconData icon, Color color) {
    final isSelected = _metodoSeleccionado == valor;
    return GestureDetector(
      onTap: () => setState(() => _metodoSeleccionado = valor),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: color, width: 1.5) : null,
        ),
        child: Column(
          children: [
            Icon(icon,
                color: isSelected ? color : EfectivaColors.grisSubtitulo,
                size: 30),
            const SizedBox(height: 6),
            Text(
              nombre,
              style: GoogleFonts.inter(
                color: isSelected ? color : EfectivaColors.grisSubtitulo,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtrasCuentasContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transferencia interbancaria',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Número de cuenta destino',
                prefixIcon: Icon(Icons.account_balance_rounded,
                    color: EfectivaColors.azulPrincipal),
              ),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Banco destino',
                prefixIcon: Icon(Icons.business_rounded,
                    color: EfectivaColors.azulPrincipal),
              ),
              items: const [
                DropdownMenuItem(value: 'bcp', child: Text('BCP')),
                DropdownMenuItem(
                    value: 'interbank', child: Text('Interbank')),
                DropdownMenuItem(value: 'bbva', child: Text('BBVA')),
                DropdownMenuItem(
                    value: 'scotiabank', child: Text('Scotiabank')),
                DropdownMenuItem(value: 'banbif', child: Text('BanBif')),
              ],
              onChanged: (v) {},
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _montoController,
              decoration: const InputDecoration(
                labelText: 'Monto',
                prefixText: 'S/ ',
                prefixIcon: Icon(Icons.attach_money_rounded,
                    color: EfectivaColors.azulPrincipal),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: EfectivaColors.azulSuave,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded,
                      color: EfectivaColors.azulPrincipal, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Costo por transferencia interbancaria: S/ 3.50',
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
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Transferir'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorialContent() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        final esEnvio = index % 2 == 0;
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
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: esEnvio
                      ? EfectivaColors.rojoSuave
                      : EfectivaColors.verdeSuave,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  esEnvio
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  color: esEnvio
                      ? EfectivaColors.rojoError
                      : EfectivaColors.verdeExito,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      esEnvio
                          ? 'Enviado a Juan Pérez'
                          : 'Recibido de María López',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      Formatters.formatFecha(
                          DateTime.now().subtract(Duration(days: index))),
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: EfectivaColors.grisSubtitulo,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                esEnvio ? '-S/ 50.00' : '+S/ 120.00',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: esEnvio
                      ? EfectivaColors.rojoError
                      : EfectivaColors.verdeExito,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _realizarTransferencia() {
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
              'Confirmar transferencia',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            _buildConfirmRow('Destino', _celularController.text),
            _buildConfirmRow('Monto', 'S/ ${_montoController.text}'),
            _buildConfirmRow(
                'Método', _metodoSeleccionado.toUpperCase()),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '✅ Transferencia exitosa',
                            style: GoogleFonts.inter(),
                          ),
                          backgroundColor: EfectivaColors.verdeExito,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: EfectivaColors.verdeExito,
                    ),
                    child: const Text('Confirmar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: EfectivaColors.grisTexto,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _montoController.dispose();
    _celularController.dispose();
    super.dispose();
  }
}
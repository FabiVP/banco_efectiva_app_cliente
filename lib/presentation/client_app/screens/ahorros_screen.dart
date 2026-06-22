import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../viewmodels/home_viewmodel.dart';

class AhorrosScreen extends StatefulWidget {
  const AhorrosScreen({super.key});

  @override
  State<AhorrosScreen> createState() => _AhorrosScreenState();
}

class _AhorrosScreenState extends State<AhorrosScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadCuentas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeVM = context.watch<HomeViewModel>();
    final cuentas = homeVM.cuentas;
    final totalSaldo = homeVM.saldoTotal;

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
                          Text(
                            'Módulo de Ahorros',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.info_outline,
                                color: Colors.white70, size: 22),
                            onPressed: () => _mostrarInfoAhorro(),
                          ),
                        ],
                      ),
                    ),
                    // Saldo de ahorro
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Saldo total ahorros',
                                style: GoogleFonts.inter(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: EfectivaColors.verdeExito
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '8.0% TEA',
                                  style: GoogleFonts.inter(
                                    color: EfectivaColors.verdeExito,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${cuentas.isNotEmpty ? cuentas.first.monedaSimbolo : 'S/'} ${totalSaldo.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildMiniStat(
                                  Icons.trending_up_rounded,
                                  'Intereses ganados',
                                  cuentas.isNotEmpty && cuentas.first.saldoInteres != null
                                      ? '${cuentas.first.monedaSimbolo} ${cuentas.first.saldoInteres!.toStringAsFixed(2)}'
                                      : 'S/ 0.00',
                                  EfectivaColors.verdeExito),
                              const SizedBox(width: 16),
                              _buildMiniStat(
                                  Icons.calendar_today_rounded,
                                  'Cuentas activas',
                                  '${cuentas.length} cuentas',
                                  EfectivaColors.amarilloAcento),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Tabs
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
                          Tab(text: 'Saldo'),
                          Tab(text: 'Depósitos'),
                          Tab(text: 'Estado de Cuenta'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          // Tab content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSaldoTab(),
                _buildDepositosTab(),
                _buildEstadoCuentaTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(
      IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                    fontSize: 10, color: Colors.white60),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaldoTab() {
    final homeVM = context.watch<HomeViewModel>();
    final cuentas = homeVM.cuentas;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...cuentas.map((c) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildCuentaAhorro(
            c.tipoCuenta ?? 'Cuenta Ahorro',
            c.codCuentaAhorro,
            '${c.monedaSimbolo} ${c.saldoCapital.toStringAsFixed(2)}',
            c.tea != null ? '${(c.tea! * 100).toStringAsFixed(1)}%' : '---',
            EfectivaColors.azulPrincipal,
          ),
        )),
        if (cuentas.isEmpty) ...[
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Text(
                'No tienes cuentas de ahorro activas',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: EfectivaColors.grisTexto,
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: 24),
        // Botón nuevo depósito
        Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            gradient: EfectivaColors.gradientePrincipal,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: EfectivaColors.azulPrincipal.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () => _nuevoDeposito(),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_circle_outline,
                        color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Nuevo depósito',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCuentaAhorro(String nombre, String numero, String saldo,
      String tea, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
                child: Icon(Icons.savings_rounded, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: EfectivaColors.negroTexto,
                      ),
                    ),
                    Text(
                      numero,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: EfectivaColors.grisSubtitulo,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: EfectivaColors.verdeSuave,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'TEA $tea',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: EfectivaColors.verdeExito,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saldo disponible',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: EfectivaColors.grisTexto,
                ),
              ),
              Text(
                saldo,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: EfectivaColors.negroTexto,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDepositosTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildDepositoItem(
          'Depósito desde cuenta',
          '14 May 2025',
          'S/ 500.00',
          true,
        ),
        _buildDepositoItem(
          'Depósito en agencia EFE',
          '10 May 2025',
          'S/ 1,000.00',
          true,
        ),
        _buildDepositoItem(
          'Retiro ATM Kasnet',
          '08 May 2025',
          'S/ 200.00',
          false,
        ),
        _buildDepositoItem(
          'Depósito en Kasnet',
          '05 May 2025',
          'S/ 300.00',
          true,
        ),
        _buildDepositoItem(
          'Depósito desde transferencia',
          '01 May 2025',
          'S/ 2,000.00',
          true,
        ),
        _buildDepositoItem(
          'Retiro en ventanilla',
          '28 Abr 2025',
          'S/ 450.00',
          false,
        ),
      ],
    );
  }

  Widget _buildDepositoItem(
      String descripcion, String fecha, String monto, bool esDeposito) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: esDeposito
                  ? EfectivaColors.verdeSuave
                  : EfectivaColors.rojoSuave,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              esDeposito
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: esDeposito
                  ? EfectivaColors.verdeExito
                  : EfectivaColors.rojoError,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  descripcion,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: EfectivaColors.negroTexto,
                  ),
                ),
                Text(
                  fecha,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: EfectivaColors.grisSubtitulo,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${esDeposito ? '+' : '-'}$monto',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: esDeposito
                  ? EfectivaColors.verdeExito
                  : EfectivaColors.rojoError,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEstadoCuentaTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Resumen mensual
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Estado de cuenta — Mayo 2025',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: EfectivaColors.negroTexto,
                ),
              ),
              const Divider(height: 24),
              _buildLineaEstado('Saldo al inicio del mes', 'S/ 10,950.00'),
              _buildLineaEstado('Total depósitos', '+S/ 3,800.00',
                  color: EfectivaColors.verdeExito),
              _buildLineaEstado('Total retiros', '-S/ 650.00',
                  color: EfectivaColors.rojoError),
              _buildLineaEstado(
                  'Intereses generados', '+S/ 83.00',
                  color: EfectivaColors.verdeExito),
              const Divider(height: 20),
              _buildLineaEstado('Saldo actual', 'S/ 14,183.00',
                  bold: true),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Resumen de tasas
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Información de tasas',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: EfectivaColors.negroTexto,
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoRow('TEA', '8.00%'),
              _buildInfoRow('TEM', '0.643%'),
              _buildInfoRow('Moneda', 'Soles (PEN)'),
              _buildInfoRow('Tipo de cuenta', 'Ahorro libre'),
              _buildInfoRow('Cuenta', '001-359-221-0001'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Botón descargar
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Estado de cuenta descargado',
                    style: GoogleFonts.inter()),
                backgroundColor: EfectivaColors.verdeExito,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          },
          icon: const Icon(Icons.download_rounded),
          label: const Text('Descargar estado de cuenta PDF'),
        ),
      ],
    );
  }

  Widget _buildLineaEstado(String label, String value,
      {Color? color, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: EfectivaColors.grisTexto,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
              color: color ?? EfectivaColors.negroTexto,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: EfectivaColors.grisTexto,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: EfectivaColors.negroTexto,
            ),
          ),
        ],
      ),
    );
  }

  void _nuevoDeposito() {
    final montoController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
            24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
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
              'Nuevo depósito',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: montoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Monto a depositar',
                prefixText: 'S/ ',
                prefixIcon: Icon(Icons.attach_money,
                    color: EfectivaColors.azulPrincipal),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Cuenta destino',
                prefixIcon: Icon(Icons.account_balance_wallet,
                    color: EfectivaColors.azulPrincipal),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'soles', child: Text('Ahorro Soles - 0001')),
                DropdownMenuItem(
                    value: 'dolares',
                    child: Text('Ahorro Dólares - 0002')),
              ],
              onChanged: (v) {},
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Depósito realizado exitosamente',
                          style: GoogleFonts.inter()),
                      backgroundColor: EfectivaColors.verdeExito,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                child: const Text('Depositar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarInfoAhorro() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Sobre tu cuenta de ahorro',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Tu cuenta de ahorros Efectiva te ofrece una tasa de interés de hasta 8% TEA. '
          'Los intereses se calculan diariamente y se abonan mensualmente.\n\n'
          'Puedes depositar y retirar en Kasnet, ATM, Tiendas EFE y La Curacao.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: EfectivaColors.grisTexto,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class CreditosScreen extends StatefulWidget {
  const CreditosScreen({super.key});

  @override
  State<CreditosScreen> createState() => _CreditosScreenState();
}

class _CreditosScreenState extends State<CreditosScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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
                            'Módulo de Créditos',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    // Resumen de créditos
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
                                'Deuda total',
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
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      size: 14,
                                      color: EfectivaColors.verdeExito,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Al día',
                                      style: GoogleFonts.inter(
                                        color: EfectivaColors.verdeExito,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'S/ 7,850.00',
                              style: GoogleFonts.inter(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildCreditStat(
                                  'Próxima cuota', 'S/ 485.00'),
                              const SizedBox(width: 16),
                              _buildCreditStat(
                                  'Vence', '15 Jun 2025'),
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
                          Tab(text: 'Préstamos Activos'),
                          Tab(text: 'Cronograma'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          // Content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPrestamosTab(),
                _buildCronogramaTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditStat(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrestamosTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildPrestamoCard(
          'Préstamo Personal',
          'PP-2024-00145',
          5000.00,
          7850.00,
          0.65,
          24,
          15,
          '18.5%',
          EfectivaColors.azulPrincipal,
        ),
        const SizedBox(height: 12),
        _buildPrestamoCard(
          'Préstamo Consumo',
          'PC-2024-00089',
          3000.00,
          3000.00,
          0.20,
          12,
          2,
          '22.0%',
          EfectivaColors.naranjaAcento,
        ),
        const SizedBox(height: 24),
        // Banner solicitar préstamo
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: EfectivaColors.gradienteNaranja,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: EfectivaColors.naranjaAcento
                    .withValues(alpha: 0.3),
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
                    Text(
                      '¿Necesitas un préstamo?',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Solicítalo 100% digital\nDesembolso en 24 horas',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Solicitar ahora',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: EfectivaColors.naranjaAcento,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.account_balance_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrestamoCard(
    String nombre,
    String codigo,
    double montoOriginal,
    double montoRestante,
    double progreso,
    int totalCuotas,
    int cuotasPagadas,
    String tea,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
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
                child: Icon(Icons.account_balance_rounded,
                    color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: EfectivaColors.negroTexto,
                      ),
                    ),
                    Text(
                      codigo,
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
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: EfectivaColors.verdeSuave,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Al día',
                  style: GoogleFonts.inter(
                    color: EfectivaColors.verdeExito,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progreso
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progreso de pago',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: EfectivaColors.grisTexto,
                ),
              ),
              Text(
                '$cuotasPagadas / $totalCuotas cuotas',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: EfectivaColors.negroTexto,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progreso,
              backgroundColor: EfectivaColors.grisClaro,
              color: color,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
          // Info
          Row(
            children: [
              _buildInfoChip('Monto original',
                  'S/ ${montoOriginal.toStringAsFixed(2)}'),
              _buildInfoChip('Monto restante',
                  'S/ ${montoRestante.toStringAsFixed(2)}'),
              _buildInfoChip('TEA', tea),
            ],
          ),
          const SizedBox(height: 12),
          // Botón pagar
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                _pagarCuota(nombre);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Pagar cuota',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: EfectivaColors.grisSubtitulo,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: EfectivaColors.negroTexto,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCronogramaTab() {
    // Datos del cronograma de pagos
    final List<Map<String, dynamic>> cuotas = [
      {
        'numero': 1,
        'fecha': '15/01/2025',
        'capital': 200.00,
        'interes': 85.00,
        'cuota': 285.00,
        'estado': 'pagada'
      },
      {
        'numero': 2,
        'fecha': '15/02/2025',
        'capital': 205.00,
        'interes': 80.00,
        'cuota': 285.00,
        'estado': 'pagada'
      },
      {
        'numero': 3,
        'fecha': '15/03/2025',
        'capital': 210.00,
        'interes': 75.00,
        'cuota': 285.00,
        'estado': 'pagada'
      },
      {
        'numero': 4,
        'fecha': '15/04/2025',
        'capital': 215.00,
        'interes': 70.00,
        'cuota': 285.00,
        'estado': 'pagada'
      },
      {
        'numero': 5,
        'fecha': '15/05/2025',
        'capital': 220.00,
        'interes': 65.00,
        'cuota': 285.00,
        'estado': 'pagada'
      },
      {
        'numero': 6,
        'fecha': '15/06/2025',
        'capital': 225.00,
        'interes': 60.00,
        'cuota': 285.00,
        'estado': 'pendiente'
      },
      {
        'numero': 7,
        'fecha': '15/07/2025',
        'capital': 230.00,
        'interes': 55.00,
        'cuota': 285.00,
        'estado': 'pendiente'
      },
      {
        'numero': 8,
        'fecha': '15/08/2025',
        'capital': 235.00,
        'interes': 50.00,
        'cuota': 285.00,
        'estado': 'pendiente'
      },
      {
        'numero': 9,
        'fecha': '15/09/2025',
        'capital': 240.00,
        'interes': 45.00,
        'cuota': 285.00,
        'estado': 'pendiente'
      },
      {
        'numero': 10,
        'fecha': '15/10/2025',
        'capital': 245.00,
        'interes': 40.00,
        'cuota': 285.00,
        'estado': 'pendiente'
      },
      {
        'numero': 11,
        'fecha': '15/11/2025',
        'capital': 250.00,
        'interes': 35.00,
        'cuota': 285.00,
        'estado': 'pendiente'
      },
      {
        'numero': 12,
        'fecha': '15/12/2025',
        'capital': 255.00,
        'interes': 30.00,
        'cuota': 285.00,
        'estado': 'pendiente'
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Encabezado
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: EfectivaColors.azulSuave,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_month_rounded,
                  color: EfectivaColors.azulPrincipal),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cronograma de Pagos',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: EfectivaColors.azulPrincipal,
                      ),
                    ),
                    Text(
                      'Préstamo Personal — PP-2024-00145',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: EfectivaColors.azulPrincipal
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Tabla header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: EfectivaColors.azulPrincipal,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(14),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: Text(
                  'N°',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Fecha',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Capital',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Interés',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Cuota',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 50),
            ],
          ),
        ),

        // Filas
        ...cuotas.map((cuota) => _buildCuotaRow(cuota)),

        const SizedBox(height: 16),
        // Descargar
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Cronograma descargado',
                    style: GoogleFonts.inter()),
                backgroundColor: EfectivaColors.verdeExito,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
          },
          icon: const Icon(Icons.download_rounded),
          label: const Text('Descargar cronograma PDF'),
        ),
      ],
    );
  }

  Widget _buildCuotaRow(Map<String, dynamic> cuota) {
    final esPagada = cuota['estado'] == 'pagada';
    final esProxima = cuota['numero'] == 6; // Primera pendiente

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: esProxima
            ? EfectivaColors.amarilloClaro
            : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: EfectivaColors.grisClaro,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '${cuota['numero']}',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: EfectivaColors.negroTexto,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              cuota['fecha'],
              style: GoogleFonts.inter(
                fontSize: 12,
                color: EfectivaColors.grisTexto,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'S/ ${cuota['capital'].toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: EfectivaColors.negroTexto,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'S/ ${cuota['interes'].toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: EfectivaColors.grisTexto,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'S/ ${cuota['cuota'].toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: EfectivaColors.negroTexto,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            width: 50,
            child: Center(
              child: esPagada
                  ? const Icon(
                      Icons.check_circle,
                      color: EfectivaColors.verdeExito,
                      size: 20,
                    )
                  : esProxima
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: EfectivaColors.naranjaAcento,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'HOY',
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.schedule,
                          color: EfectivaColors.grisSubtitulo,
                          size: 18,
                        ),
            ),
          ),
        ],
      ),
    );
  }

  void _pagarCuota(String prestamo) {
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
              'Pagar cuota',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              prestamo,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: EfectivaColors.grisTexto,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: EfectivaColors.azulSuave,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monto de cuota',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: EfectivaColors.grisTexto,
                    ),
                  ),
                  Text(
                    'S/ 285.00',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: EfectivaColors.azulPrincipal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cuota pagada exitosamente',
                          style: GoogleFonts.inter()),
                      backgroundColor: EfectivaColors.verdeExito,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                child: const Text('Confirmar pago'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

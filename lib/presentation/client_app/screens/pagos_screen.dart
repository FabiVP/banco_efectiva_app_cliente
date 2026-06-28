import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/repositories/cuenta_repository.dart';
import '../../../core/api/api_client.dart';

class PagosScreen extends StatefulWidget {
  const PagosScreen({super.key});

  @override
  State<PagosScreen> createState() => _PagosScreenState();
}

class _PagosScreenState extends State<PagosScreen> {
  String _categoriaSeleccionada = '';
  final _codigoController = TextEditingController();
  final _montoController = TextEditingController();
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  final CuentaRepository _repo = CuentaRepository(api: ApiClient());

  final List<Map<String, dynamic>> _categorias = [
    {'nombre': 'Luz Y Gas', 'icon': Icons.lightbulb_outline_rounded},
    {'nombre': 'Agua', 'icon': Icons.water_drop_outlined},
    {'nombre': 'Teléfono', 'icon': Icons.phone_outlined},
    {'nombre': 'Recargas', 'icon': Icons.phone_android_outlined},
    {'nombre': 'Pago Efectivo', 'icon': Icons.payments_outlined},
    {'nombre': 'Otras Categorías', 'icon': Icons.more_horiz_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EfectivaColors.grisFondo,
      appBar: AppBar(
        title: const Text('Servicios o instituciones'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              _searchFocusNode.requestFocus();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Text(
                'Selecciona el servicio que quieres pagar',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: EfectivaColors.negroTexto,
                ),
              ),
            ),
            // Buscador
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: 'Buscar empresa',
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: EfectivaColors.grisSubtitulo),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // Categorías
            ...List.generate(_categorias.length, (index) {
              final cat = _categorias[index];
              return _buildCategoriaItem(
                cat['icon'] as IconData,
                cat['nombre'] as String,
                index < _categorias.length - 1,
              );
            }),

            const SizedBox(height: 16),

            // Formulario de pago (si hay categoría seleccionada)
            if (_categoriaSeleccionada.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        'Pago de $_categoriaSeleccionada',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _codigoController,
                        decoration: InputDecoration(
                          labelText: 'Código de cliente / DNI',
                          prefixIcon: const Icon(Icons.badge_outlined,
                              color: EfectivaColors.azulPrincipal),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _montoController,
                        decoration: InputDecoration(
                          labelText: 'Monto a pagar',
                          prefixText: 'S/ ',
                          prefixIcon: const Icon(Icons.attach_money_rounded,
                              color: EfectivaColors.azulPrincipal),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _realizarPago,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: EfectivaColors.verdeExito,
                          ),
                          child: const Text('Pagar ahora'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Pagos favoritos
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
              child: Text(
                'Pagos favoritos',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: EfectivaColors.negroTexto,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildFavoritoCard(
                    'Luz del Sur',
                    'Código: 1234567',
                    'S/ 45.00',
                    Icons.lightbulb_outline_rounded,
                    EfectivaColors.naranjaAcento,
                  ),
                  _buildFavoritoCard(
                    'Sedapal',
                    'Código: 8901234',
                    'S/ 32.50',
                    Icons.water_drop_outlined,
                    EfectivaColors.azulPrincipal,
                  ),
                  _buildFavoritoCard(
                    'Movistar',
                    'Internet fibra',
                    'S/ 89.00',
                    Icons.wifi_rounded,
                    const Color(0xFF7C3AED),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriaItem(IconData icon, String nombre, bool showDivider) {
    final isSelected = _categoriaSeleccionada == nombre;
    return Column(
      children: [
        Material(
          color: isSelected ? EfectivaColors.azulSuave : Colors.white,
          child: InkWell(
            onTap: () => setState(() {
              _categoriaSeleccionada =
                  _categoriaSeleccionada == nombre ? '' : nombre;
            }),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? EfectivaColors.azulPrincipal
                          : EfectivaColors.grisFondo,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: isSelected
                          ? Colors.white
                          : EfectivaColors.grisTexto,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      nombre,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? EfectivaColors.azulPrincipal
                            : EfectivaColors.negroTexto,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: isSelected
                        ? EfectivaColors.azulPrincipal
                        : EfectivaColors.grisSubtitulo,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 0, indent: 78),
      ],
    );
  }

  Widget _buildFavoritoCard(String nombre, String subtitle, String monto,
      IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          nombre,
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
        trailing: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: EfectivaColors.azulPrincipal,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Pagar',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: () {
          setState(() {
            _codigoController.text = '1234567';
            _montoController.text = monto.replaceAll('S/ ', '');
          });
        },
      ),
    );
  }

  void _realizarPago() {
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
              'Confirmar pago',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            _buildConfirmRow('Servicio', _categoriaSeleccionada),
            _buildConfirmRow('Código', _codigoController.text),
            _buildConfirmRow('Monto', 'S/ ${_montoController.text}'),
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
                    onPressed: () async {
                      Navigator.pop(ctx);
                      try {
                        await _repo.crearOperacion(
                          codCuentaOrigen: '',
                          tipo: 'PAG',
                          monto: double.tryParse(_montoController.text) ?? 0,
                          concepto: 'Pago de $_categoriaSeleccionada - ${_codigoController.text}',
                          canal: 'APP',
                          moneda: 'PEN',
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('✅ Pago realizado exitosamente',
                                  style: GoogleFonts.inter()),
                              backgroundColor: EfectivaColors.verdeExito,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e',
                                  style: GoogleFonts.inter()),
                              backgroundColor: EfectivaColors.rojoError,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: EfectivaColors.verdeExito,
                    ),
                    child: const Text('Pagar'),
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
    _codigoController.dispose();
    _montoController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
}
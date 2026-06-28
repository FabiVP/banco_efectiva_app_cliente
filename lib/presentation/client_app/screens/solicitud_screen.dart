import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../viewmodels/solicitud_viewmodel.dart';

class SolicitudScreen extends StatelessWidget {
  const SolicitudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SolicitudViewModel(),
      child: _SolicitudForm(),
    );
  }
}

class _SolicitudForm extends StatefulWidget {
  @override
  State<_SolicitudForm> createState() => _SolicitudFormState();
}

class _SolicitudFormState extends State<_SolicitudForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _ingresoCtrl = TextEditingController();
  final _gastoCtrl = TextEditingController();
  final _patrimonioCtrl = TextEditingController();
  final _montoCtrl = TextEditingController();
  final _destinoCtrl = TextEditingController();
  final _picker = ImagePicker();

  // Signature
  final List<List<Offset>> _signaturePoints = [];
  List<Offset> _currentPoints = [];

  static const _tiposNegocio = [
    'comercio', 'servicios', 'manufactura', 'restaurante',
    'transporte', 'agropecuario', 'construccion', 'otros',
  ];
  static const _garantias = [
    'sin_garantia', 'hipotecaria', 'vehicular', 'prendaria', 'aval',
  ];

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _ingresoCtrl.dispose();
    _gastoCtrl.dispose();
    _patrimonioCtrl.dispose();
    _montoCtrl.dispose();
    _destinoCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage(DocType tipo) async {
    final file = await _picker.pickImage(source: ImageSource.camera, maxWidth: 1024);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    final vm = context.read<SolicitudViewModel>();
    vm.addDocumento(DocUpload(tipo, bytes, file.name));
  }

  Widget _buildDocButton(DocType tipo, String label, IconData icon) {
    final vm = context.watch<SolicitudViewModel>();
    final hasDoc = vm.documentos.any((d) => d.tipo == tipo);
    return OutlinedButton.icon(
      onPressed: () => _pickImage(tipo),
      icon: Icon(hasDoc ? Icons.check_circle : icon,
          color: hasDoc ? EfectivaColors.verdeExito : null, size: 20),
      label: Text(label, style: GoogleFonts.inter(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: hasDoc ? EfectivaColors.verdeExito : EfectivaColors.grisClaro),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SolicitudViewModel>();
    return Scaffold(
      backgroundColor: EfectivaColors.grisFondo,
      appBar: AppBar(
        title: Text('Solicitar Crédito',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        backgroundColor: EfectivaColors.azulPrincipal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (vm.state == SolicitudState.success) ...[
                _buildSuccessSection(vm),
              ] else ...[
                _buildField('Tipo de negocio',
                  DropdownButtonFormField<String>(
                    initialValue: vm.tipoNegocio,
                    decoration: _inputDec(),
                    items: _tiposNegocio.map((t) => DropdownMenuItem(
                      value: t, child: Text(_capitalize(t)),
                    )).toList(),
                    onChanged: (v) { if (v != null) vm.setTipoNegocio(v); },
                  )),
                _buildField('Nombre del negocio',
                  TextFormField(
                    controller: _nombreCtrl,
                    decoration: _inputDec(hint: 'Ej: Bodega Don Anaxi'),
                    onChanged: (v) => vm.setNombreNegocio(v),
                  )),
                _buildField('Ingreso mensual estimado (S/)',
                  TextFormField(
                    controller: _ingresoCtrl,
                    decoration: _inputDec(hint: 'Ej: 2500'),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => vm.setIngresosEstimados(double.tryParse(v) ?? 0),
                  )),
                _buildField('Gasto mensual (S/)',
                  TextFormField(
                    controller: _gastoCtrl,
                    decoration: _inputDec(hint: 'Opcional'),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => vm.setGastosMensuales(double.tryParse(v)),
                  )),
                _buildField('Patrimonio estimado (S/)',
                  TextFormField(
                    controller: _patrimonioCtrl,
                    decoration: _inputDec(hint: 'Opcional'),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => vm.setPatrimonioEstimado(double.tryParse(v)),
                  )),
                _buildField('Monto solicitado (S/)',
                  TextFormField(
                    controller: _montoCtrl,
                    decoration: _inputDec(hint: 'Ej: 5000'),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || (double.tryParse(v) ?? 0) <= 0) return 'Ingrese un monto válido';
                      return null;
                    },
                    onChanged: (v) => vm.setMontoSolicitado(double.tryParse(v) ?? 0),
                  )),
                _buildField('Plazo (meses)',
                  DropdownButtonFormField<int>(
                    initialValue: vm.plazoMeses,
                    decoration: _inputDec(),
                    items: [6, 12, 18, 24, 36].map((m) => DropdownMenuItem(
                      value: m, child: Text('$m meses'),
                    )).toList(),
                    onChanged: (v) { if (v != null) vm.setPlazoMeses(v); },
                  )),
                _buildField('Garantía',
                  DropdownButtonFormField<String>(
                    initialValue: vm.garantia,
                    decoration: _inputDec(),
                    items: _garantias.map((g) => DropdownMenuItem(
                      value: g, child: Text(_capitalize(g.replaceAll('_', ' '))),
                    )).toList(),
                    onChanged: (v) { if (v != null) vm.setGarantia(v); },
                  )),
                _buildField('Destino del crédito',
                  TextFormField(
                    controller: _destinoCtrl,
                    decoration: _inputDec(hint: 'Ej: Capital de trabajo'),
                    maxLines: 2,
                    onChanged: (v) => vm.setDestinoCredito(v),
                  )),
                const SizedBox(height: 16),
                // Signature pad
                _buildSignaturePad(vm),
                const SizedBox(height: 24),
                if (vm.state == SolicitudState.error)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: EfectivaColors.rojoError.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(vm.errorMessage ?? 'Error',
                        style: GoogleFonts.inter(color: EfectivaColors.rojoError, fontSize: 13)),
                  ),
                SizedBox(
                  width: double.infinity, height: 52,
                  child: ElevatedButton(
                    onPressed: vm.state == SolicitudState.loading ? null : () {
                      if (_formKey.currentState?.validate() ?? false) vm.enviarSolicitud();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: EfectivaColors.naranjaAcento,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: vm.state == SolicitudState.loading
                        ? const SizedBox(width: 24, height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text('Enviar solicitud',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessSection(SolicitudViewModel vm) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: EfectivaColors.verdeExito.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: EfectivaColors.verdeExito),
          ),
          child: Column(
            children: [
              const Icon(Icons.check_circle, size: 64, color: EfectivaColors.verdeExito),
              const SizedBox(height: 16),
              Text('¡Solicitud enviada!',
                  style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: EfectivaColors.verdeExito)),
              const SizedBox(height: 8),
              Text('Expediente: ${vm.expediente ?? "---"}',
                  style: GoogleFonts.inter(fontSize: 14, color: EfectivaColors.negroTexto)),
              const SizedBox(height: 4),
              Text('Un asesor se comunicará contigo.',
                  style: GoogleFonts.inter(fontSize: 13, color: EfectivaColors.grisTexto)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Document upload section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.upload_file, color: EfectivaColors.azulPrincipal),
                  const SizedBox(width: 8),
                  Text('Subir documentos',
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 8),
              Text('Toma foto de tus documentos para agilizar la evaluación.',
                  style: GoogleFonts.inter(fontSize: 12, color: EfectivaColors.grisTexto)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: [
                  _buildDocButton(DocType.dniAnverso, 'DNI Anverso', Icons.badge),
                  _buildDocButton(DocType.dniReverso, 'DNI Reverso', Icons.badge_outlined),
                  _buildDocButton(DocType.fotoNegocio, 'Foto negocio', Icons.store),
                  _buildDocButton(DocType.ruc, 'RUC', Icons.description),
                  _buildDocButton(DocType.recibo, 'Recibo servicio', Icons.receipt),
                ],
              ),
              if (vm.documentos.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text('${vm.documentos.length} documento(s) seleccionado(s)',
                    style: GoogleFonts.inter(fontSize: 12, color: EfectivaColors.verdeExito)),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: vm.documentos.isEmpty ? null : () {
                    vm.subirTodosDocumentos();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Documentos enviados', style: GoogleFonts.inter()),
                        backgroundColor: EfectivaColors.verdeExito,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: vm.docState == SolicitudState.loading
                      ? const SizedBox(width: 18, height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.cloud_upload),
                  label: Text('Subir documentos'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: EfectivaColors.azulPrincipal,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Volver'),
          ),
        ),
      ],
    );
  }

  Widget _buildSignaturePad(SolicitudViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.draw, size: 18, color: EfectivaColors.grisTexto),
            const SizedBox(width: 6),
            Text('Firma del cliente',
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: EfectivaColors.grisTexto)),
            if (_signaturePoints.isNotEmpty) ...[
              const Spacer(),
              GestureDetector(
                onTap: () { setState(() { _signaturePoints.clear(); _currentPoints.clear(); }); },
                child: Text('Limpiar', style: GoogleFonts.inter(fontSize: 12, color: EfectivaColors.rojoError)),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: EfectivaColors.grisClaro),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onPanStart: (_) { _currentPoints = []; },
              onPanUpdate: (d) {
                setState(() {
                  _currentPoints.add(d.localPosition);
                  if (_signaturePoints.isEmpty) _signaturePoints.add([]);
                  _signaturePoints.last = List.from(_currentPoints);
                });
              },
              onPanEnd: (_) { _signaturePoints.add([]); },
              child: CustomPaint(
                painter: _SignaturePainter(_signaturePoints.expand((p) => p).toList()),
                size: const Size(double.infinity, 120),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildField(String label, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(label,
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: EfectivaColors.grisTexto)),
          ),
          child,
        ],
      ),
    );
  }

  InputDecoration _inputDec({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(color: EfectivaColors.grisSubtitulo),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: EfectivaColors.grisClaro),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  String _capitalize(String s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}

class _SignaturePainter extends CustomPainter {
  final List<Offset> points;
  _SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;
    final paint = Paint()
      ..color = EfectivaColors.negroTexto
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter old) => old.points != points;
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/auth_models.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login con email y contraseña
  Future<Usuario?> login(String email, String password) async {
    try {
      print('🔐 PASO 1: Iniciando login para $email');
      
      // 1. Autenticar usuario
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final String uid = userCredential.user!.uid;
      print('✅ PASO 2: Auth exitoso. UID: $uid');
      
      // 2. Intentar obtener datos de Firestore
      print('🔍 PASO 3: Buscando documento en Firestore...');
      DocumentSnapshot userDoc = await _firestore
          .collection('usuarios')
          .doc(uid)
          .get();
      
      // 3. Si no existe el documento, crearlo automáticamente
      if (!userDoc.exists) {
        print('📝 PASO 4: Documento no existe, creando perfil automático...');
        
        final Map<String, dynamic> nuevoUsuario = {
          'uid': uid,
          'email': email,
          'nombreCompleto': email.split('@').first,
          'dni': '12345678',
          'telefono': '999888777',
          'fotoUrl': null,
          'fechaRegistro': FieldValue.serverTimestamp(),
          'dispositivosConfianza': [],
          'saldoCapital': 635.00,
          'interesesAcumulados': 6.35,
          'numeroCuenta': '0013592210001',
        };
        
        await _firestore.collection('usuarios').doc(uid).set(nuevoUsuario);
        print('✅ PASO 5: Perfil creado exitosamente');
        
        return Usuario.fromJson(nuevoUsuario);
      }
      
      // 4. Si existe, obtener los datos
      print('✅ Documento encontrado');
      final Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      print('📄 Campos: ${data.keys}');
      
      // 5. Crear usuario con los datos
      final usuario = Usuario.fromJson(data);
      
      print('✅ PASO 6: Usuario cargado: ${usuario.nombreCompleto}');
      print('💰 Saldo: S/ ${usuario.saldoCapital}');
      print('📊 Intereses: S/ ${usuario.interesesAcumulados}');
      print('💳 Cuenta: ${usuario.numeroCuenta}');
      
      return usuario;
      
    } on FirebaseAuthException catch (e) {
      print('❌ FirebaseAuthException: ${e.code} - ${e.message}');
      throw _handleAuthError(e);
    } catch (e) {
      print('❌ Error general: $e');
      throw Exception('Error desconocido: $e');
    }
  }

  // Registrar nuevo usuario
  Future<Usuario> register(String email, String password, String dni) async {
    try {
      print('📝 Registrando nuevo usuario: $email');
      
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final String uid = userCredential.user!.uid;
      
      // Generar número de cuenta único
      final String numeroCuenta = '001${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 12)}';
      
      final Map<String, dynamic> nuevoUsuario = {
        'uid': uid,
        'email': email,
        'nombreCompleto': '',
        'dni': dni,
        'telefono': '',
        'fotoUrl': null,
        'fechaRegistro': FieldValue.serverTimestamp(),
        'dispositivosConfianza': [],
        'saldoCapital': 0.0,
        'interesesAcumulados': 0.0,
        'numeroCuenta': numeroCuenta,
      };
      
      await _firestore.collection('usuarios').doc(uid).set(nuevoUsuario);
      
      print('✅ Usuario registrado exitosamente');
      print('💳 Número de cuenta: $numeroCuenta');
      
      return Usuario.fromJson(nuevoUsuario);
      
    } on FirebaseAuthException catch (e) {
      print('❌ FirebaseAuthException: ${e.code}');
      throw _handleAuthError(e);
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Error al registrar: $e');
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    await _auth.signOut();
    print('✅ Sesión cerrada');
  }

  // Guardar dispositivo de confianza
  Future<void> agregarDispositivoConfianza(String userId, String deviceId) async {
    await _firestore.collection('usuarios').doc(userId).update({
      'dispositivosConfianza': FieldValue.arrayUnion([deviceId]),
    });
  }

  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'Usuario no encontrado';
        case 'wrong-password':
          return 'Contraseña incorrecta';
        case 'email-already-in-use':
          return 'El correo ya está registrado';
        case 'invalid-email':
          return 'Email inválido';
        case 'weak-password':
          return 'Contraseña demasiado débil';
        case 'network-request-failed':
          return 'Error de conexión. Verifica tu internet';
        default:
          return 'Error: ${error.message}';
      }
    }
    return 'Error desconocido: $error';
  }
}
import '../../core/api/api_client.dart';
import '../models/auth_models.dart';

class AuthRepository {
  final ApiClient _api = ApiClient();

  Future<({String token, Usuario usuario})> register({
    required String dni,
    required String nombres,
    required String apellidos,
    required String telefono,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _api.post('/cliente/register', body: {
        'numero_documento': dni,
        'nombres': nombres,
        'apellidos': apellidos,
        'telefono': telefono,
        'email': email,
        'password': password,
      });

      final token = response['access_token']?.toString() ?? '';
      final clienteData = response['cliente'] as Map<String, dynamic>?;

      if (token.isEmpty || clienteData == null) {
        throw Exception('Error al crear la cuenta');
      }

      await _api.setToken(token);
      final usuario = Usuario.fromJson(clienteData);
      return (token: token, usuario: usuario);
    } on ApiException catch (e) {
      if (e.statusCode == 409) {
        throw Exception('El DNI ya está registrado');
      }
      throw Exception(e.message);
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error de conexión. Verifica tu conexión a internet');
    }
  }

  Future<({String token, Usuario usuario})> login(String dni, String password) async {
    try {
      final response = await _api.post('/cliente/login', body: {
        'numero_documento': dni,
        'password': password,
      });

      final token = response['access_token']?.toString() ?? '';
      final clienteData = response['cliente'] as Map<String, dynamic>?;

      if (token.isEmpty || clienteData == null) {
        throw Exception('Credenciales inválidas');
      }

      await _api.setToken(token);
      final usuario = Usuario.fromJson(clienteData);
      return (token: token, usuario: usuario);
    } on ApiException catch (e) {
      if (e.statusCode == 423) {
        throw Exception('Usuario bloqueado por intentos fallidos');
      }
      throw Exception(e.message);
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error de conexión. Verifica tu conexión a internet');
    }
  }

  Future<Usuario> getPerfil() async {
    try {
      final response = await _api.get('/cliente/perfil');
      return Usuario.fromJson(response);
    } on ApiException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> logout() async {
    await _api.setToken(null);
  }

  Future<bool> isLoggedIn() async {
    return _api.isAuthenticated;
  }
}

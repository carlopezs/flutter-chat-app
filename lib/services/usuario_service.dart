import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/models/usuarios_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp =
          await http.get(Uri.parse('${Environment.apiUrl}/usuarios'), headers: {
        'Content-type': 'application/json',
        'x-token': await AuthService.getToken(),
      });

      final usuariosResponse = UsuariosResponse.fromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}

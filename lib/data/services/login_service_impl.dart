import 'package:first_project_flutter/domain/entities/login.dart';
import 'package:first_project_flutter/domain/services/login_service.dart';

class LoginServiceImpl extends LoginService{
  @override
  Future<Login> obtenhaLogin({required String usuario, required String senha}) async{
    if(usuario == 'pedro' && senha == '654321'){
      return Login(usuario: usuario, senha: senha, token: 'token');
    }

    throw Exception("Login inválido");
  }
}
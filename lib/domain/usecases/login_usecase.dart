import 'package:dartz/dartz.dart';
import 'package:first_project_flutter/domain/entities/login.dart';
import 'package:first_project_flutter/domain/erros/failure.dart';
import 'package:first_project_flutter/domain/services/login_service.dart';

class LoginUseCase{
  final LoginService loginService;

  LoginUseCase({required this.loginService});

  Future<Either<Failure, Login>> realizeLogin({required String usuario, required String senha}) async{
    if(usuario.isEmpty || senha.isEmpty){
      return Left(ErrorLogin(mensagem: "Informe login e senha"));
    }

    try{
      var login = await loginService.obtenhaLogin(usuario: usuario, senha: senha);
      return Right(login);
    }catch(ex){
      return Left(ErrorLogin(mensagem: ex.toString()));
    }
  }
}
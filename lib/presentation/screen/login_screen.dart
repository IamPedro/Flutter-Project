import 'package:first_project_flutter/presentation/Widgets/widget_helper.dart';
import 'package:first_project_flutter/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injector.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => getIt(),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state){
            if(state.isSucesso){
              BlocProvider.of<ApplicationBloc>(context).add(
                  ApplicationLoginEvent(token: state.token!)
              );
            }
            if(state.isErro){
              WidgetHelper.showError(context, state.erro!);
            }
            return Container(
              color: const Color(0xFF5E37DB),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomPaint(
                        painter: ShapesPainter(),
                        child:
                          SizedBox(
                            width: 380,
                            height: 250,
                            child: Image.asset("assets/logo.png"),
                          ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 20,
                        left: 40,
                        right: 40
                    ),
                    child: Text(
                      "Hi There!",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontStyle: FontStyle.normal
                      ),
                      textAlign: TextAlign.center
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 40,
                        right: 40
                    ),
                    child: Text(
                      "Login to continue:",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontStyle: FontStyle.normal
                      ),
                      textAlign: TextAlign.center
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20,
                        left: 40,
                        right: 40
                    ),
                    child:
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        controller: _usuarioController,
                        decoration: const InputDecoration(
                            hintText: "Email or Username",
                            hintStyle: TextStyle(color: Colors.black26),
                            suffixIcon: Icon(Icons.person_outline, color: Colors.black26)
                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20,
                        left: 40,
                        right: 40
                    ),
                    child:
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _senhaController,
                        decoration: const InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.black26),
                            suffixIcon: Icon(Icons.lock, color: Colors.black26)
                        ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20,
                        left: 40,
                        right: 40
                    ),
                    child:
                      TextButton(
                        onPressed: () => BlocProvider.of<LoginBloc>(context).add(
                            LoginPressedButtonEvent(
                                usuario: _usuarioController.text,
                                senha: _senhaController.text
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Login', style: TextStyle(color: Colors.white)),
                            Icon(Icons.arrow_forward_ios, color: Colors.white)
                          ],
                        ),
                        style:
                          ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(
                                0xFFE89C54))
                          ),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30,
                        left: 40,
                        right: 40
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Register', style: TextStyle(color: Colors.black26), textAlign: TextAlign.left),
                        Text('Forgot?', style: TextStyle(color: Colors.black26), textAlign: TextAlign.right)
                      ]
                    ),
                  ),
                ],
              )
            );
          },
        ),
      ),
    );
  }
}

const double _kCurveHeight = 35;

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    p.lineTo(0, size.height - _kCurveHeight);
    p.relativeQuadraticBezierTo(size.width / 2, 2 * _kCurveHeight, size.width, 0);
    p.lineTo(size.width, 0);
    p.close();

    canvas.drawPath(p, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
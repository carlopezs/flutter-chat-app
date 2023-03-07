import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(
                    titulo: 'Registro',
                  ),
                  _Form(),
                  const Labels(
                    ruta: 'login',
                    primaryText: 'Ingresa ahora',
                    secondaryText: '¿Ya tienes una cuenta?',
                  ),
                  const Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            textController: nameCtrl,
          ),

          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),

          //TODO: Crear botón
          BotonAzul(
              text: 'Registrarse',
              onPressed: authService.isLogin
                  ? null
                  : () async {
                      final register = await authService.register(
                          nameCtrl.text.trim(),
                          emailCtrl.text.trim(),
                          passCtrl.text.trim());
                      Future.microtask(() {
                        if (register == true) {
                          //TODO: Conectar al socket server
                          Navigator.popAndPushNamed(context, 'usuarios');
                        } else {
                          mostrarAlerta(
                              context, 'Registro Incorecto', register);
                        }
                      });
                    })
        ],
      ),
    );
  }
}

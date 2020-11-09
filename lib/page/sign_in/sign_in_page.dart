import 'package:flutter/material.dart';
import 'package:my_place/exceptions/exceptions.dart';
import 'package:my_place/page/carrinho/carrinho_controller.dart';
import 'package:my_place/page/home/home_page.dart';
import 'package:my_place_utils/my_place_utils.dart';
import 'package:my_place/widget/mp_loading.dart';
import 'package:my_place_models/models/models.dart';
import 'package:provider/provider.dart';

import '../../exceptions/exceptions.dart';
import '../../widget/mp_logo.dart';
import '../sign_up/sign_up_page.dart';
import 'sign_in_controller.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = SignInController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: _controller.isLoading
            ? Center(
                child: MPLoading(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MPLogo(),
                        const SizedBox(height: 24),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            prefixIcon: Icon(
                              Icons.mail,
                              size: 24,
                            ),
                          ),
                          validator: (email) =>
                              email.isEmpty ? 'Campo Obrigatório' : null,
                          onSaved: _controller.setEmail,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 24,
                            ),
                          ),
                          obscureText: true,
                          validator: (senha) =>
                              senha.isEmpty ? 'Campo Obrigatório' : null,
                          onSaved: _controller.setSenha,
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: 120,
                          child: RaisedButton(
                            onPressed: () async {
                              final form = _formKey.currentState;
                              if (form.validate()) {
                                setState(() {
                                  _controller.setIsLoading(true);
                                });
                                form.save();
                                try {
                                  final usuario = await _controller.fazLogin();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (_) => Provider<UsuarioModel>(
                                        create: (_) => usuario,
                                        child: Provider<CarrinhoController>(
                                          create: (_) =>
                                              CarrinhoController(usuario),
                                          child: HomePage(),
                                        ),
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                } on UsuarioNaoEncontradoException {
                                  showWarningToast('Usuário não encontrado');
                                } on SenhaErradaException {
                                  showWarningToast('Senha inválida');
                                } on EmailInvalidoException {
                                  showWarningToast('Email inválido');
                                } on ClienteInvalidoException {
                                  showWarningToast('Este usuário não é cliente');
                                } on Exception {
                                  showErrorToast('Ocorreu um erro inesperado');
                                } finally {
                                  setState(() {
                                    _controller.setIsLoading(false);
                                  });
                                }
                              }
                            },
                            child: Text('Entrar'),
                          ),
                        ),
                        Container(
                          width: 120,
                          child: OutlineButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => SignUpPage(),
                              ),
                            ),
                            child: Text('Cadastrar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx/components/personalized_button_component.dart';
import 'package:olx/components/snackbar_component.dart';
import 'package:olx/pages/login/login_provider.dart';
import 'package:olx/components/textfield_component.dart';
import 'package:olx/utils/app_routes.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _register = false;
  final TextEditingController _emailController =
      TextEditingController(text: 'mattheussbarbosa@hotmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '123456');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _loginOrRegister(LoginProvider loginProvider) async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    if (_register) {
      await loginProvider.register(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } else {
      await loginProvider.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }

    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.announcements, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    width: 500,
                    child: Image.asset('lib/assets/images/logo.png'),
                  ),
                  const SizedBox(height: 30),
                  TextFieldComponent(
                    enabled: loginProvider.isLoading ? false : true,
                    autoFocus: true,
                    label: 'E-mail',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o e-mail';
                      } else if (!value.contains('@')) {
                        return 'E-mail inválido';
                      } else if (!value.contains('.')) {
                        return 'E-mail inválido';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFieldComponent(
                    enabled: loginProvider.isLoading ? false : true,
                    textEditingController: _passwordController,
                    label: 'Senha',
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite a senha';
                      } else if (value.length < 6) {
                        return 'A senha deve conter no mínimo 6 caracteres';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Switch(
                        value: _register,
                        onChanged: loginProvider.isLoading
                            ? null
                            : (value) {
                                setState(() {
                                  _register = value;
                                });
                              },
                      ),
                      const Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  PersonalizedButtonComponent(
                    onPressed: () async {
                      await _loginOrRegister(loginProvider);

                      if (loginProvider.errorMessage != '') {
                        SnackBarComponent.showSnackbar(
                          context: context,
                          message: loginProvider.errorMessage,
                        );
                      }
                    },
                    text: 'Login',
                    isLoading: loginProvider.isLoading,
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

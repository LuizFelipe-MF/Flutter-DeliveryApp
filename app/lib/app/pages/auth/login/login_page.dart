import 'package:app/app/core/ui/base_state/base_state.dart';
import 'package:app/app/core/ui/styles/text_styles.dart';
import 'package:app/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:app/app/core/ui/widgets/delivery_button.dart';
import 'package:app/app/pages/auth/login/login_controller.dart';
import 'package:app/app/pages/auth/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          login: () => showLoader(),
          loginError: () {
            hideLoader();
            showError('E-mail ou senha inválidos.');
          },
          error: () {
            hideLoader();
            showError('Erro ao realizar login.');
          },
          success: () {
            hideLoader();
            Navigator.pop(context, true);
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: context.textStyle.textTitle,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _emailEC,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.required('E-mail obrigatório.'),
                          Validatorless.email('E-mail inválido'),
                        ]),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _passwordEC,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                        ),
                        validator: Validatorless.required('Senha obrigatória.'),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: DeliveryButton(
                            width: double.infinity,
                            label: 'ENTRAR',
                            onPressed: () {
                              final valid =
                                  _formKey.currentState?.validate() ?? false;

                              if (valid) {
                                controller.login(
                                    _emailEC.text, _passwordEC.text);
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não possui conta? ',
                        style: context.textStyle.textBold,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/auth/register');
                        },
                        child: Text(
                          'Cadastre-se',
                          style: context.textStyle.textBold
                              .copyWith(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

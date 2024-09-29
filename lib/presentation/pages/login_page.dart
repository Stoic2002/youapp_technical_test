import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:youapp_technical_test/presentation/bloc/auth/auth_bloc.dart';
import 'package:youapp_technical_test/core/constants/app_colors.dart';
import 'package:youapp_technical_test/data/models/auth_model.dart';
import 'package:youapp_technical_test/presentation/pages/profile_page.dart';
import 'package:youapp_technical_test/presentation/pages/register_page.dart';
import 'package:youapp_technical_test/presentation/widgets/custom_button.dart';
import 'package:youapp_technical_test/presentation/widgets/custom_textfield.dart';
import 'package:youapp_technical_test/presentation/widgets/gardient_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const ProfilePage()),
          // );
          context.go('/profile');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration:
                const BoxDecoration(gradient: AppColors.backgroundGradient),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 158.0),
                const Padding(
                  padding: EdgeInsets.only(left: 41),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 23, right: 25),
                  child: Column(
                    children: [
                      CustomTextField(
                        labelText: 'Username/Email',
                        hintText: 'Enter your Username/Email',
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 11.0),
                      CustomTextField(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        isPassword: true,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: 'Login',
                        onPressed: _isFormValid
                            ? () {
                                _login();
                              }
                            : null,
                        enabled: _isFormValid && state is! AuthLoading,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 46),
                GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'No account? ',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              fontSize: 13),
                        ),
                        InkWell(
                            onTap: () {
                              context.push('/register');
                            },
                            child: const GradientText(
                              text: 'Register Here',
                              gradient: AppColors.goldenGradient,
                              underline: true,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    String email = '';
    String username = '';

    // Cek apakah input berupa email atau username
    if (_usernameController.text.contains('@')) {
      email = _usernameController.text;
    } else {
      username = _usernameController.text;
    }

    // Dispatch LoginEvent dengan field yang sesuai
    context.read<AuthBloc>().add(
          LoginEvent(
            authModel: AuthModel(
              email: email,
              userName: username,
              password: _passwordController.text,
            ),
          ),
        );
  }
}

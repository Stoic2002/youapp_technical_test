import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:youapp_technical_test/presentation/bloc/auth/auth_bloc.dart';
import 'package:youapp_technical_test/core/constants/app_colors.dart';
import 'package:youapp_technical_test/data/models/auth_model.dart';
import 'package:youapp_technical_test/presentation/widgets/custom_back_button.dart';
import 'package:youapp_technical_test/presentation/widgets/custom_button.dart';
import 'package:youapp_technical_test/presentation/widgets/custom_textfield.dart';
import 'package:youapp_technical_test/presentation/widgets/gardient_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _emailController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Registration successful. Please login.')),
          );
          context.pop();
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration:
                const BoxDecoration(gradient: AppColors.backgroundGradient),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 81),
                const Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: CustomBackButton(),
                ),
                const SizedBox(height: 33.0),
                const Padding(
                  padding: EdgeInsets.only(left: 41),
                  child: Text(
                    'Register',
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
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 11.0),
                      CustomTextField(
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        controller: _usernameController,
                      ),
                      const SizedBox(height: 11.0),
                      CustomTextField(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        isPassword: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 11.0),
                      CustomTextField(
                        labelText: 'Confirm Password',
                        hintText: 'Re-enter your password',
                        isPassword: true,
                        controller: _confirmPasswordController,
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
                        text: 'Register',
                        onPressed: _isFormValid
                            ? () {
                                context.read<AuthBloc>().add(
                                      RegisterEvent(
                                          authModel: AuthModel(
                                              email: _emailController.text,
                                              userName:
                                                  _usernameController.text,
                                              password:
                                                  _passwordController.text)),
                                    );
                              }
                            : null,
                        enabled: _isFormValid && state is! AuthLoading,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 46),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have an account? ',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              fontSize: 13),
                        ),
                        InkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: const GradientText(
                                underline: true,
                                text: 'Login Here',
                                gradient: AppColors.goldenGradient)),
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
}

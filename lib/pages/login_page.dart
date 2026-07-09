import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;

  void _submit() async {
    // when pressed the login or sign up the validation shows up
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      bool sucess;

      if (_isLogin) {
        sucess = await authProvider.signIn(email, password);
      } else {
        sucess = await authProvider.signUp(email, password);
      }

      if (!sucess && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? "sonething went wrong"),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 80,
                color: AppColors.primary,
              ),
              SizedBox(height: 32),
              Text(
                _isLogin ? 'Welcome Back !' : 'Create an account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 12),
              Text(
                _isLogin
                    ? 'Sign in to continue managing your tasks'
                    : 'Join us and start organizing your life',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
              ),
              SizedBox(height: 48),

              //wrap column within a form
              Form(
                key: _formKey,
                //wrap textformfields within a column
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction:
                          TextInputAction.next, // next to next textform field
                      validator: (value) => value != null && value.contains('@')
                          ? null
                          : 'enter a valid email',
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      validator: (value) => value != null && value.length > 6
                          ? null
                          : 'password must be at least 6 characters', //submits after done
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(_isLogin ? 'Log In' : 'Sign Up'),
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isLogin
                              ? 'Don\'t have an account'
                              : 'Already have an account',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        SizedBox(height: 32),

                        if (authProvider.isLoading)
                          Center(child: CircularProgressIndicator())
                        else
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(
                              _isLogin ? 'Sign up' : 'Login',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

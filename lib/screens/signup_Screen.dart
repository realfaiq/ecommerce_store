import 'package:ecommerce_store/utils/styles.dart';
import 'package:ecommerce_store/widgets/ecoButton.dart';
import 'package:flutter/material.dart';
import '../widgets/textField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePasswordController = TextEditingController();
  bool isPassword = true;
  bool isRetypePassword = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Welcome, \n Please Create your Account',
                style: EcommerceStore.boldStyle,
                textAlign: TextAlign.center,
              ),
              Column(
                children: [
                  Form(
                      child: Column(
                    children: [
                      EcoTextField(
                        hintText: 'Email....',
                        controller: _emailController,
                      ),
                      EcoTextField(
                        isPassword: isPassword,
                        hintText: 'Password....',
                        controller: _passwordController,
                        icon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          icon: isPassword
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                      EcoTextField(
                        isPassword: isRetypePassword,
                        hintText: 'Re-type Password....',
                        controller: _retypePasswordController,
                        icon: IconButton(
                          onPressed: () {
                            setState(() {
                              isRetypePassword = !isRetypePassword;
                            });
                          },
                          icon: isRetypePassword
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ),
                      EcoButton(
                        title: 'SIGN UP',
                        isLogIn: true,
                      ),
                    ],
                  ))
                ],
              ),
              EcoButton(
                title: 'Back to Login',
                onPress: () {
                  Navigator.pop(context);
                },
                isLogIn: false,
              ),
            ]),
      ),
    ));
  }
}

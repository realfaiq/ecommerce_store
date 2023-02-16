import 'package:ecommerce_store/screens/login_Screen.dart';
import 'package:ecommerce_store/services/firebase_Services.dart';
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
  final formKey = GlobalKey<FormState>();
  bool formStateLoading = false;
  bool isPassword = true;
  bool isRetypePassword = true;
  FocusNode? emailFocus;
  FocusNode? passwordFocusNode;
  FocusNode? retypePasswordFocusNode;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    emailFocus?.dispose();
    passwordFocusNode?.dispose();
    retypePasswordFocusNode?.dispose();
  }

  Future<void> ecoDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              EcoButton(
                title: 'CLOSE',
                onPress: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  submit() async {
    if (formKey.currentState!.validate()) {
      if (_passwordController.text == _retypePasswordController.text) {
        setState(() {
          formStateLoading = true;
        });
        String? res = await FirebaseServices.createAccount(
            _emailController.text, _passwordController.text);
        if (res != null) {
          ecoDialogue(res.toString());
          setState(() {
            formStateLoading = false;
          });
        } else {
          Navigator.pop(context);
        }
      }
    }
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
                      key: formKey,
                      child: Column(
                        children: [
                          EcoTextField(
                            validate: (v) {
                              if (v!.isEmpty ||
                                  !v.contains('@') ||
                                  !v.contains('.com')) {
                                return 'Email is badly Formatted';
                              }
                              return null;
                            },
                            hintText: 'Email....',
                            controller: _emailController,
                            textInputAction: TextInputAction.next,
                            focusNode: emailFocus,
                          ),
                          EcoTextField(
                            isPassword: isPassword,
                            validate: (v) {
                              if (v!.isEmpty) {
                                return 'Password should not be Empty';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            hintText: 'Password....',
                            controller: _passwordController,
                            focusNode: passwordFocusNode,
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
                            validate: (v) {
                              if (v!.isEmpty) {
                                return 'Password should not be Empty';
                              }
                              return null;
                            },
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
                            onPress: submit,
                            title: 'SIGN UP',
                            isLogIn: true,
                            isLoading: formStateLoading,
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

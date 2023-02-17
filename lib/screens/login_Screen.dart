import 'package:ecommerce_store/screens/home_Screen.dart';
import 'package:ecommerce_store/screens/signup_Screen.dart';
import 'package:ecommerce_store/utils/styles.dart';
import 'package:ecommerce_store/widgets/ecoButton.dart';
import 'package:flutter/material.dart';
import '../services/firebase_Services.dart';
import '../widgets/textField.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formKey = GlobalKey<FormState>();
  bool formStateLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
      setState(() {
        formStateLoading = true;
      });
      String? res = await FirebaseServices.signInAccount(
          _emailController.text, _passwordController.text);
      if (res != null) {
        ecoDialogue(res.toString());
        setState(() {
          formStateLoading = false;
        });
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    }
  }

  bool isPassword = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                'Welcome, \n Please Log In First',
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
                            hintText: 'Email....',
                            controller: _emailController,
                          ),
                          EcoTextField(
                            hintText: 'Password....',
                            isPassword: isPassword,
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
                          EcoButton(
                            title: 'LOG IN',
                            isLogIn: true,
                            isLoading: formStateLoading,
                            onPress: submit,
                          ),
                        ],
                      ))
                ],
              ),
              EcoButton(
                title: 'Create new Account',
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpScreen()));
                },
                isLogIn: false,
              ),
            ]),
      ),
    ));
  }
}

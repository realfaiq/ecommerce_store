import 'package:ecommerce_store/screens/signup_Screen.dart';
import 'package:ecommerce_store/utils/styles.dart';
import 'package:ecommerce_store/widgets/ecoButton.dart';
import 'package:flutter/material.dart';
import '../widgets/textField.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isPassword = true;
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
                      child: Column(
                    children: [
                      EcoTextField(hintText: 'Email....'),
                      EcoTextField(
                        hintText: 'Password....',
                        isPassword: isPassword,
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

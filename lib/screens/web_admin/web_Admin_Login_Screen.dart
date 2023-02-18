import 'package:ecommerce_store/screens/web_admin/web_Main.dart';
import 'package:ecommerce_store/services/firebase_Services.dart';
import 'package:ecommerce_store/utils/styles.dart';
import 'package:ecommerce_store/widgets/ecoButton.dart';
import 'package:ecommerce_store/widgets/ecoDialogue.dart';
import 'package:ecommerce_store/widgets/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WebAdminLogInScreen extends StatefulWidget {
  static const String routeName = 'weblogin';
  const WebAdminLogInScreen({super.key});

  @override
  State<WebAdminLogInScreen> createState() => _WebAdminLogInScreenState();
}

class _WebAdminLogInScreenState extends State<WebAdminLogInScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _userNameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool formStateLoading = false;

    submit() async {
      if (formKey.currentState!.validate()) {
        setState(() {
          formStateLoading = true;
        });
        await FirebaseServices.adminSignIn(_userNameController.text)
            .then((value) async {
          if (value['username'] == _userNameController.text &&
              value['password'] == _passwordController.text) {
            try {
              UserCredential user =
                  await FirebaseAuth.instance.signInAnonymously();
              if (user != null) {
                Navigator.pushReplacementNamed(
                    context, WebMainScreen.routeName);
              }
            } catch (e) {
              setState(() {
                formStateLoading = false;
              });
              showDialog(
                  context: context,
                  builder: (_) {
                    return EcoDialogue(title: e.toString());
                  });
            }
          }
        });
      }
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'WELCOME ADMIN!',
                      style: EcommerceStore.boldStyle,
                    ),
                    const Text(
                      'Log In to Admin Panel!',
                      style: EcommerceStore.boldStyle,
                    ),
                    EcoTextField(
                      controller: _userNameController,
                      hintText: 'Email',
                    ),
                    EcoTextField(
                      controller: _passwordController,
                      isPassword: true,
                      hintText: 'Password',
                    ),
                    EcoButton(
                      isLogIn: true,
                      title: 'Log In',
                      isLoading: formStateLoading,
                      onPress: () {
                        submit();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

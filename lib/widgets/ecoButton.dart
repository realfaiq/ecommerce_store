import 'package:flutter/material.dart';

class EcoButton extends StatelessWidget {
  String? title;
  bool isLogIn;
  VoidCallback? onPress;
  bool? isLoading;
  EcoButton({
    this.title,
    this.isLogIn = false,
    this.onPress,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isLogIn ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
          ),
          child: Stack(
            children: [
              Visibility(
                visible: isLoading! ? false : true,
                child: Center(
                  child: Text(
                    title ?? 'button',
                    style: TextStyle(
                        color: isLogIn ? Colors.white : Colors.black,
                        fontSize: 16),
                  ),
                ),
              ),
              Visibility(
                visible: isLoading!,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          )),
    );
  }
}

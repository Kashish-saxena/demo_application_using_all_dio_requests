import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUserData extends StatefulWidget {
  const LoginUserData({super.key, required this.email});
  final String email;
  @override
  State<LoginUserData> createState() => _LoginUserDataState();
}

class _LoginUserDataState extends State<LoginUserData> {
  removeValues() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    data.remove("email");
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/Successmark.png"),
              const Text(
                "Logged In",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "User Email: ${widget.email}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(370, 60),
                  backgroundColor: const Color(0xff1E232C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  removeValues();
                  log("$removeValues");
                },
                child: const Text("Logout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

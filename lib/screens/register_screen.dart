import 'package:api_project/models/signup_request_model.dart';
import 'package:api_project/screens/user_screen.dart';
import 'package:api_project/services/post_api_service.dart';
import 'package:api_project/utils/signup_verification.dart';
import 'package:api_project/widgets/radio_field.dart';
import 'package:api_project/widgets/text_form_field.dart';

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterScreen> {
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String gender = "male";

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Form(
              key: _registerKey,
              child: Column(
                children: [
                  const Text(
                    "Hello! Register to get started",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldWidget(
                    validator: (val) {
                      return Verification.isNameValid(val);
                    },
                    obscureText: false,
                    controller: nameController,
                    text: "Name",
                  ),
                  TextFormFieldWidget(
                    validator: (val) {
                      return Verification.isEmailValid(val);
                    },
                    obscureText: false,
                    controller: emailController,
                    text: "Email",
                  ),
                  RadioFieldWidget(
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Gender",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xff8391A1))),
                        Flexible(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            textColor: Color(0xff8391A1),
                            leading: Radio(
                                value: "Male",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value ?? "";
                                  });
                                }),
                            title: const Text("Male"),
                          ),
                        ),
                        Flexible(
                          child: ListTile(
                            textColor: Color(0xff8391A1),
                            contentPadding: EdgeInsets.zero,
                            leading: Radio(
                                value: "Female",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value ?? "";
                                  });
                                }),
                            title: const Text("Female"),
                          ),
                        )
                      ],
                    ),
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
                    onPressed: () async {
                      if (_registerKey.currentState!.validate()) {
                        const snackBar =
                            SnackBar(content: Text('User Registered!'));
                        SignUpRequestModel signUpRequestModel =
                            SignUpRequestModel(
                                name: nameController.text,
                                email: emailController.text,
                                gender: gender,
                                status: "Active");
                        bool isSuccess =
                            await PostApiService.postData(signUpRequestModel);
                        if (isSuccess) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserScreen(),
                              ));
                        } else {
                          const snackBar = SnackBar(
                              content: const Text('User Not Registered!'));
                        }

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text("Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Or Register With',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 45, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Image.asset("assets/images/facebook.png",
                            fit: BoxFit.contain),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 45, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {},
                        child: Image.asset(
                          "assets/images/google.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 45, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {},
                        child: Image.asset(
                          "assets/images/apple.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff032426)),
                      ),
                      InkWell(
                        child: const Text(
                          "Login Now",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

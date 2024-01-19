import 'dart:developer';
import 'package:api_project/models/signup_request_model.dart';
import 'package:api_project/screens/user_screen.dart';
import 'package:api_project/services/update_api_service.dart';
import 'package:api_project/utils/signup_verification.dart';
import 'package:api_project/widgets/radio_field.dart';
import 'package:api_project/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen(
      {super.key,
      required this.userId,
      this.userName,
      this.userEmail,
      this.userGender,
      required this.userStatus});
  final int userId;
  final String? userName;
  final String? userEmail;
  final String? userGender;
  final String userStatus;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final GlobalKey<FormState> _updateKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? gender;

  @override
  void initState() {
    super.initState();
    log(widget.userGender ?? "");
    nameController.text = widget.userName ?? "";
    emailController.text = widget.userEmail ?? "";
    gender = widget.userGender ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Update Screen",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _updateKey,
            child: Column(
              children: [
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
                    text: "Email"),
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
                          textColor: const Color(0xff8391A1),
                          contentPadding: EdgeInsets.zero,
                          leading: Radio(
                              value: "male",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              }),
                          title: const Text("Male"),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          textColor: const Color(0xff8391A1),
                          contentPadding: EdgeInsets.zero,
                          leading: Radio(
                              value: "female",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              }),
                          title: const Text("Female"),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(370, 60),
                    backgroundColor: const Color(0xff1E232C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () async {
                    if (_updateKey.currentState!.validate()) {
                      String updatedName = nameController.text;
                      String updatedEmail = emailController.text;
                      String updatedGender = gender ?? "";

                      if (updatedName != widget.userName ||
                          updatedEmail != widget.userEmail ||
                          updatedGender != widget.userGender) {
                        SignUpRequestModel signUpRequestModel =
                            SignUpRequestModel(
                          name: updatedName,
                          email: updatedEmail,
                          gender: updatedGender,
                          status: "Active",
                        );
                        bool isSuccess = await UpdateApiService.updateUser(
                          widget.userId,
                          signUpRequestModel,
                        );
                        if (isSuccess && context.mounted) {
                          const snackBar = SnackBar(
                            content: Text("User Details updated"),
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserScreen()));
                        } else {
                          log("Failed to load because email already exists...");
                          const snackBar = SnackBar(
                            content: Text(
                                "Failed to load because email already exists..."),
                            duration: Duration(seconds: 2),
                          );
                          if (context.mounted) {
                            //throwing the warning that buildcontext can't be used in async

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      } else {
                        log("Failed to load because email already exists...");
                        const snackBar = SnackBar(
                          content: Text(
                              "Failed to load because email already exists..."),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: const Text("Update",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

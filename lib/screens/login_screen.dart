// import 'dart:developer';

// import 'package:api_using_dio/models/signup_response_model.dart';
// import 'package:api_using_dio/screens/home_screen.dart';
// import 'package:api_using_dio/services/get_api_service.dart';
// import 'package:api_using_dio/utils/signup_verification.dart';
// import 'package:api_using_dio/widgets/text_form_field.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({
//     super.key,
//   });
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   List<SignUpResponseModel> userData = [];

//   // init() async {
//   //   await GetApiService.getData().then((value) {
//   //     userData = value;
//   //     setState(() {
        
//   //     });
//   //   });
//   // }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   init();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.greenAccent,
//         title: const Text("Login Screen"),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 10),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 TextFormFieldWidget(
//                   validator: (val) {
//                     return Verification.isEmailValid(val);
//                   },
//                   text: "Email",
//                   obscureText: false,
//                   controller: emailController,
//                 ),
//                 TextFormFieldWidget(
//                   validator: (value) {
//                     return null;
//                   },
//                   text: "Password",
//                   obscureText: true,
//                   controller: passwordController,
//                 ),
//                 Container(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.greenAccent,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                     onPressed: () {
//                       log(">>>>>>>>>>>>>>>>>>>>>>>>$userData");
//                       // GetApiService.getData(id: "5971275");
                      
//                       // (GetApiService.getEmail() == emailController.text)
//                       //     ? log(0000000000)
//                       //     : log(92423222);
//                     },
//                     child: const Text("Login",
//                         style: TextStyle(color: Colors.black)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

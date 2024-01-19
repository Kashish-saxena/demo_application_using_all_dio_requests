import 'dart:developer';
import 'package:api_project/models/signup_response_model.dart';
import 'package:api_project/screens/update_screen.dart';
import 'package:api_project/services/delete_api_service.dart';
import 'package:api_project/services/get_api_service.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<List<SignUpResponseModel>> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = GetApiService.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'User Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<SignUpResponseModel>>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No data available'),
            );
          }
          List<SignUpResponseModel> userList = snapshot.data!;
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              SignUpResponseModel user = userList[index];
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: const Color(0xffF7F8F9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xffE8ECF4)),
                ),
                child: ListTile(
                  title: Text(
                    "Name: ${user.name}",
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    'Email: ${user.email}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          bool isSuccess =
                              await DeleteApiService.deleteUser(user.id ?? 0);
                          if (isSuccess) {
                            setState(() {
                              _userDataFuture = GetApiService.getData();
                            });
                            const snackBar = SnackBar(
                              content: Text("User Deleted"),
                              duration: Duration(seconds: 2),
                            );
                            if (context.mounted) {
                              //throwing the warning that buildcontext can't be used in async

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            log("Failed to Delete");
                            const snackBar = SnackBar(
                                content: Text("Failed to Delete"),
                                duration: Duration(seconds: 2));
                            if (context.mounted) {
                              //throwing the warning that buildcontext can't be used in async

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateScreen(
                                        userName: user.name,
                                        userId: user.id ?? 0,
                                        userEmail: user.email,
                                        userGender: user.gender,
                                        userStatus: "Active",
                                      )));
                          setState(() {
                            _userDataFuture = GetApiService.getData();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

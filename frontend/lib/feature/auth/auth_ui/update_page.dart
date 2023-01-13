import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_bloc/bloc/update_user_bloc.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_bloc/handle_api/registrasi_bloc.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_model/response_get_user.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_ui/login_page.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_ui/home_page.dart';
import 'package:flutter_application_singkatin/helper/color_helper.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_button.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateUserPage extends StatefulWidget {
  ResponseGetUser user;
  UpdateUserPage({super.key, required this.user});

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final _emailController = TextEditingController(text: '');
  final _firstNameController = TextEditingController(text: '');
  final _lastNameController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _phoneController = TextEditingController(text: '');

  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? phone;

  final _updateUserBloc = UpdateUserBloc();

  @override
  void initState() {
    var data = widget.user.data!;
    email = data.email;
    firstName = data.firstName;
    lastName = data.lastName;
    phone = data.phone;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: BlocConsumer<UpdateUserBloc, UpdateUserState>(
        bloc: _updateUserBloc,
        listener: (context, state) {
          if (state is UpdateUserSuccess) {
            // _tokenHelper.saveToken(state.responseUpdateUser?.data!.token ?? '');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (state is UpdateUserError) {
            if (state.responseError!.message == "user already exist") {
              Fluttertoast.showToast(
                msg: "user already exist",
                textColor: ColorHelper.primary,
                backgroundColor: Colors.white,
              );
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  children: [
                    const Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          PrimaryTextField(
                            textEditingController: _emailController
                              ..text = widget.user.data!.email!,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          PrimaryTextField(
                            textEditingController: _firstNameController
                              ..text = widget.user.data!.firstName!,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          PrimaryTextField(
                            textEditingController: _lastNameController
                              ..text = widget.user.data!.lastName!,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          PrimaryTextField(
                            textEditingController: _phoneController
                              ..text = widget.user.data!.phone!,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          PrimaryTextField(
                            textEditingController: _passwordController,
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: PrimaryButton(
                        onPressed: () {
                          if (_emailController.text.isEmpty &&
                              _passwordController.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Masukkan username dan password",
                              textColor: ColorHelper.primary,
                              backgroundColor: Colors.white,
                            );
                          } else if (_emailController.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Masukkan username",
                              textColor: ColorHelper.primary,
                              backgroundColor: Colors.white,
                            );
                          } else {
                            _updateUserBloc.add(
                              UpdateUser(
                                email: _emailController.text,
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                phone: "083812379277",
                                password: "",
                              ),
                            );
                          }
                        },
                        text: "Sign Up",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget makeInput({label, obsureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obsureText,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ],
  );
}

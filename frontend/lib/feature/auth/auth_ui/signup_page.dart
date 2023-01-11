import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_bloc/handle_api/registrasi_bloc.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_ui/login_page.dart';
import 'package:flutter_application_singkatin/helper/color_helper.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_button.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController(text: 'testing@gmail.com');
  final _firstNameController = TextEditingController(text: 'iyan');
  final _lastNameController = TextEditingController(text: 'Zulistiyan');
  final _passwordController = TextEditingController(text: 'hekalPassAmanDong');
  final _passwordConfirmationController =
      TextEditingController(text: 'hekalPassAmanDong');

  final _registrasiBloc = RegistrasiBloc();
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
      body: BlocConsumer<RegistrasiBloc, RegistrasiState>(
        bloc: _registrasiBloc,
        listener: (context, state) {
          if (state is RegistrasiSuccess) {
            // _tokenHelper.saveToken(state.responseRegistrasi?.data!.token ?? '');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          } else if (state is RegistrasiError) {
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
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create an Account,Its free",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          PrimaryTextField(
                            textEditingController: _emailController,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          PrimaryTextField(
                            textEditingController: _firstNameController,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          PrimaryTextField(
                            textEditingController: _lastNameController,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          PrimaryTextField(
                            textEditingController: _passwordController,
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          PrimaryTextField(
                            textEditingController:
                                _passwordConfirmationController,
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
                          } else if (_passwordController.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Masukkan sandi",
                              textColor: ColorHelper.primary,
                              backgroundColor: Colors.white,
                            );
                          } else {
                            _registrasiBloc.add(
                              PostRegister(
                                email: _emailController.text,
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                password: _passwordController.text,
                                passwordConfirmation:
                                    _passwordConfirmationController.text,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          ),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.blue),
                          ),
                        ),
                      ],
                    )
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

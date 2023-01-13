import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_bloc/event/login_event.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_bloc/handle_api/login_bloc.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_ui/signup_page.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_ui/home_page.dart';
import 'package:flutter_application_singkatin/helper/color_helper.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_button.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_textfield.dart';
import 'package:flutter_application_singkatin/helper/token_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _loginBloc = LoginBloc();
  final TokenHelper _tokenHelper = TokenHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state is LoginSuccess) {
            _tokenHelper.saveToken(state.responseLogin?.data!.token ?? '');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          } else if (state is LoginError) {
            debugPrint(state.responseError!.message);
            if (state.responseError!.message == "Wrong Password" ||
                state.responseError!.message == "user not found") {
              Fluttertoast.showToast(
                msg: "Pastikan email/password benar",
                textColor: ColorHelper.primary,
                backgroundColor: Colors.white,
              );
            }
          }
        },
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome back ! Login with your credentials",
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
                      SizedBox(
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
                      text: 'Login',
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
                          _loginBloc.add(
                            PostLogin(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                        }
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont have an account?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
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

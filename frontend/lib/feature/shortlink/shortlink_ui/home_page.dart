import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_bloc/bloc/get_user_bloc.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_ui/signup_page.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_ui/update_page.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/create_short_url_auth_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/create_short_url_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/delete_url_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/get_active_subs_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/get_list_url_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_ui/pack_page.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_ui/subscription/links_page.dart';
import 'package:flutter_application_singkatin/helper/color_helper.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_button.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_textfield.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/secoundary_buton.dart';
import 'package:flutter_application_singkatin/helper/token_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/auth_ui/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _getUserBloc = GetUserBloc();

  final _createUrlBloc = CreateShortUrlBloc();
  final _createUrlAuthBloc = CreateShortUrlAuthBloc();
  final _longUrlController = TextEditingController(text: '');
  final _longUrlAuthController = TextEditingController(text: '');
  final _getActivateSubs = GetActiveSubsBloc();

  final _titleUrlController = TextEditingController(text: '');

  final _shortUrlController = TextEditingController(text: '');
  bool isLogin = false;
  @override
  void initState() {
    _getActivateSubs.add(GetActiveSubs());
    _getUserBloc.add(GetUser());
    // Future.delayed(Duration.zero, () async {
    //   final TokenHelper _tokenHelper = TokenHelper();
    //   String token = await _tokenHelper.getToken();
    //   if (token.isEmpty) {
    //     isLogin = false;
    //   } else {
    //     isLogin = true;
    //   }
    // });

    super.initState();
  }

  void _logout() {
    const storage = FlutterSecureStorage();
    storage.delete(key: 'token').then(
          (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          ),
        );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      endDrawer: BlocConsumer<GetUserBloc, GetUserState>(
        bloc: _getUserBloc,
        listener: (context, state) {
          debugPrint('state is $state');
        },
        builder: (context, state) {
          if (state is GetUserLoading) {
          } else if (state is GetUserSuccess) {
            return Drawer(
              child: ListView(
                padding: const EdgeInsets.all(0.0),
                children: [
                  UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: ColorHelper.primary,
                    ),
                    accountName: Text(
                      "${state.responseGetUser!.data!.firstName}"
                      " ${state.responseGetUser!.data!.lastName}",
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                    accountEmail: Text(
                      state.responseGetUser!.data!.email!,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        state.responseGetUser!.data!.firstName!,
                        style: GoogleFonts.montserrat(color: Colors.black),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text("Links"),
                    trailing: const Icon(Icons.list_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LinksPage(),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("Update Profile"),
                    trailing: const Icon(Icons.person),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateUserPage(
                            user: state.responseGetUser!,
                          ),
                        ),
                      )
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("Subscription"),
                    trailing: const Icon(Icons.money_rounded),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PackPage(),
                        ),
                      )
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("Logout"),
                    trailing: const Icon(Icons.logout),
                    onTap: () => _logout(),
                  ),
                ],
              ),
            );
          } else if (state is GetUserError) {}
          return const SizedBox();
        },
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: () => _key.currentState!.openEndDrawer(),
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
          ),
        ],
        title: Text(
          "SingkatinAja.id",
          style: GoogleFonts.poppins(
            color: ColorHelper.primary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<GetActiveSubsBloc, GetActiveSubsState>(
        bloc: _getActivateSubs,
        listener: (context, state) {
          debugPrint('state is $state');
        },
        builder: (context, stateActvateSubs) {
          if (stateActvateSubs is GetActiveSubsLoading) {
          } else if (stateActvateSubs is GetActiveSubsSuccess) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Short Links WithSuperpowers",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "SingkatinAja.id is an link management tool for modern marketing teams to create, share, and track short links.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Text(
                          'Masukkan Link',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        PrimaryTextField(
                          textEditingController: _longUrlController,
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<CreateShortUrlBloc, CreateShortUrlState>(
                    bloc: _createUrlBloc,
                    listener: (context, state) {
                      if (state is CreateShortUrlSuccess) {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              insetPadding: const EdgeInsets.all(24),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 24),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0))),
                              title: Text(
                                'Short Link ',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await Clipboard.setData(
                                          ClipboardData(
                                            text: state.responseCreateShortUrl!
                                                .data!.shortUrl!,
                                          ),
                                        );
                                        Fluttertoast.showToast(
                                          msg: "Copy ke Clipboard",
                                          textColor: ColorHelper.primary,
                                          backgroundColor: Colors.white,
                                        );
                                      },
                                      child: Text(
                                        state.responseCreateShortUrl!.data!
                                            .shortUrl!,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: PrimaryButton(
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PackPage(),
                                        ),
                                      );
                                    },
                                    text: "Upgrade your links",
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } else if (state is CreateShortUrlError) {
                        Fluttertoast.showToast(
                          msg: "Error",
                          textColor: ColorHelper.primary,
                          backgroundColor: Colors.white,
                        );
                        // if (state.responseError!.message == "notFound-login") {

                        // }
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(24),
                        child: PrimaryButton(
                          onPressed: () {
                            if (_longUrlController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Isi Link Dulu",
                                textColor: ColorHelper.primary,
                                backgroundColor: Colors.white,
                              );
                            } else {
                              _createUrlBloc.add(
                                PostCreateUrl(
                                  longUrl: _longUrlController.text,
                                ),
                              );
                            }
                          },
                          text: "Singkatin",
                        ),
                      );
                    },
                  ),
                  BlocConsumer<CreateShortUrlAuthBloc, CreateShortUrlAuthState>(
                    bloc: _createUrlAuthBloc,
                    listener: (context, state) {
                      if (state is CreateShortUrlAuthSuccess) {
                        Navigator.pop(context);
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              insetPadding: const EdgeInsets.all(24),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 24),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0))),
                              title: Text(
                                'Short Link',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    Text(
                                      state.responseCreateShortUrlAuth!.data!
                                          .shortUrl!,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: PrimaryButton(
                                    onPressed: () async {},
                                    text: "Lihat History Link",
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } else if (state is CreateShortUrlAuthError) {
                        Fluttertoast.showToast(
                          msg: "Error",
                          textColor: ColorHelper.primary,
                          backgroundColor: Colors.white,
                        );
                        // if (state.responseError!.message == "notFound-login") {

                        // }
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SecoundaryButton(
                          text: stateActvateSubs
                                      .responseGetActiveSubs!.data!.status ==
                                  'active'
                              ? 'Custom Link'
                              : 'Logout',
                          onPressed: () {
                            if (stateActvateSubs
                                    .responseGetActiveSubs!.data!.status ==
                                'active') {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    insetPadding: const EdgeInsets.all(24),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 24),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.0))),
                                    title: Text(
                                      'Custom Link',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          TextFormField(
                                            controller: _longUrlAuthController,
                                            decoration: const InputDecoration(
                                              labelText: 'Destination URL',
                                              labelStyle: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 17,
                                                fontFamily: 'AvenirLight',
                                              ),
                                              hintText: "Destination URL",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          TextFormField(
                                            controller: _titleUrlController,
                                            decoration: const InputDecoration(
                                              labelText: 'Title (optional)',
                                              labelStyle: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 17,
                                                fontFamily: 'AvenirLight',
                                              ),
                                              hintText: "Title (optional)",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 60,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xffF6F5F6),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Skt.id/",
                                                  style: TextStyle(
                                                    color: Color(0xff7C7C7D),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  controller:
                                                      _shortUrlController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Shortlink',
                                                    labelStyle: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 17,
                                                      fontFamily: 'AvenirLight',
                                                    ),
                                                    hintText: "Shortlink",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 16, 16),
                                        child: PrimaryButton(
                                          onPressed: () async {
                                            _createUrlAuthBloc
                                                .add(PostCreateUrlAuth(
                                              longUrl:
                                                  _longUrlAuthController.text,
                                              name: _titleUrlController.text,
                                              shortUrl:
                                                  _shortUrlController.text,
                                            ));
                                          },
                                          text: "Save",
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            } else {
                              _logout();
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (stateActvateSubs is GetActiveSubsError) {}
          return Container();
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

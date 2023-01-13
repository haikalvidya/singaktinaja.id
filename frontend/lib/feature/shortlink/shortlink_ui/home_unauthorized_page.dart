import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_singkatin/feature/auth/auth_ui/signup_page.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/payment_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/create_short_url_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_ui/pack_page.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_ui/pembayaran_page.dart';
import 'package:flutter_application_singkatin/helper/color_helper.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_button.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_textfield.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/secoundary_buton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeUnAuthorizedPage extends StatefulWidget {
  const HomeUnAuthorizedPage({super.key});

  @override
  State<HomeUnAuthorizedPage> createState() => _HomeUnAuthorizedPageState();
}

class _HomeUnAuthorizedPageState extends State<HomeUnAuthorizedPage> {
  final _createUrlBloc = CreateShortUrlBloc();
  final _longUrlController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "SingkatinAja.id",
          style: GoogleFonts.poppins(
            color: ColorHelper.primary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
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
                                      text: state.responseCreateShortUrl!.data!
                                          .shortUrl!,
                                    ),
                                  );
                                  Fluttertoast.showToast(
                                    msg: "Copy ke Clipboard",
                                    textColor: ColorHelper.primary,
                                    backgroundColor: Colors.white,
                                  );
                                },
                                child: Text(
                                  state.responseCreateShortUrl!.data!.shortUrl!,
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
                        actions: <Widget>[],
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SecoundaryButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
                text: 'Register Now',
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  cardStarterPack(context, '50.000', 'Starter Pack',
                      '2bcc8066-78d6-4863-87b1-f2873849d8e4'),
                  cardBasicPack(context, '150.000', 'Basic Pack',
                      'c5c21a03-614a-4d1a-92cc-55b295bb1082'),
                  cardPremiumPack(context, '250.000', 'Premium Pack',
                      '2b4ecb9e-3ee5-40b9-b46e-de96b859855b'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget cardStarterPack(
    BuildContext context, String nominal, String judul, String idPaket) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(24),
    child: Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(8),
      shadowColor: Colors.black.withOpacity(0.6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              judul,
              style: GoogleFonts.montserrat(
                fontSize: 24,
                color: ColorHelper.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rp${nominal}',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '/bulan',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Icon(
                  Icons.link,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  '10 links only',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.dashboard,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  'Dashboard',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.person,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  'Links',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.link,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  'Custome links',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            PrimaryButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                );
              },
              text: 'Upgrade Now',
            )
          ],
        ),
      ),
    ),
  );
}

Widget cardBasicPack(
    BuildContext context, String nominal, String judul, String idPaket) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(24),
    child: Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(8),
      shadowColor: Colors.black.withOpacity(0.6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              judul,
              style: GoogleFonts.montserrat(
                fontSize: 24,
                color: ColorHelper.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rp${nominal}',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '/bulan',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Icon(
                  Icons.link,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  '1.500 links only',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.dashboard,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  'Dashboard',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.person,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  'Links',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.folder,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  '50 Microsite',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.link,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  'Custome links',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            PrimaryButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                );
              },
              text: 'Upgdare Now',
            )
          ],
        ),
      ),
    ),
  );
}

Widget cardPremiumPack(
    BuildContext context, String nominal, String judul, String idPaket) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(24),
    child: Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(8),
      shadowColor: Colors.black.withOpacity(0.6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              judul,
              style: GoogleFonts.montserrat(
                fontSize: 24,
                color: ColorHelper.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rp${nominal}',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '/bulan',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Icon(
                  Icons.link,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  'Unlimited links only',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.dashboard,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  'Dashboard',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.person,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  'Links',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.folder,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  'Unlimited Microsite',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const Icon(
                  Icons.link,
                  size: 30,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  'Custome links',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            PrimaryButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                );
              },
              text: 'Upgdare Now',
            )
          ],
        ),
      ),
    ),
  );
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

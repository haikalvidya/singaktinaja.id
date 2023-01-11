import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/payment_bloc.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_ui/pembayaran_page.dart';
import 'package:flutter_application_singkatin/helper/color_helper.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PackPage extends StatefulWidget {
  const PackPage({super.key});

  @override
  State<PackPage> createState() => _PackPageState();
}

class _PackPageState extends State<PackPage> {
  final _paymentBloc = PaymentBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorHelper.backgroundGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
        title: Text(
          "SingkatinAja.id",
          style: GoogleFonts.poppins(
            color: ColorHelper.primary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            "Choose your pack now",
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
            'Generate, share and track branded links for every form of communication.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          cardStarterPack(context, '50.000', 'Starter Pack',
              '2bcc8066-78d6-4863-87b1-f2873849d8e4'),
          cardBasicPack(context, '150.000', 'Basic Pack',
              'c5c21a03-614a-4d1a-92cc-55b295bb1082'),
          cardPremiumPack(context, '250.000', 'Premium Pack',
              '2b4ecb9e-3ee5-40b9-b46e-de96b859855b'),
        ],
      ),
    );
  }

  Widget cardStarterPack(
      BuildContext context, String nominal, String judul, String idPaket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        shadowColor: Colors.black.withOpacity(0.3),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: ColorHelper.primary,
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
                        Text(
                          'Rp${nominal}',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '/bulan',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
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
                          'Benefit Pack',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
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
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          BlocConsumer<PaymentBloc, PaymentState>(
                            bloc: _paymentBloc,
                            listener: (context, state) {
                              if (state is PaymentSuccess) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewExample(
                                      url: state
                                          .responsePayment!.data!.urlPayment!,
                                    ),
                                  ),
                                );
                              } else {}
                            },
                            builder: (context, state) {
                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: PrimaryButton(
                                  onPressed: () {
                                    _paymentBloc.add(
                                      PaymentUpgradePaket(
                                        idPaket: idPaket,
                                      ),
                                    );
                                  },
                                  text: "Upgrade your links",
                                ),
                              );
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xffDDDDDD)),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: ColorHelper.primary,
                  ),
                ),
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
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        shadowColor: Colors.black.withOpacity(0.3),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: ColorHelper.primary,
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
                        Text(
                          'Rp${nominal}',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '/bulan',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
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
                          'Benefit Pack',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
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
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          BlocConsumer<PaymentBloc, PaymentState>(
                            bloc: _paymentBloc,
                            listener: (context, state) {
                              if (state is PaymentSuccess) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewExample(
                                      url: state
                                          .responsePayment!.data!.urlPayment!,
                                    ),
                                  ),
                                );
                              } else {}
                            },
                            builder: (context, state) {
                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: PrimaryButton(
                                  onPressed: () {
                                    _paymentBloc.add(
                                      PaymentUpgradePaket(
                                        idPaket: idPaket,
                                      ),
                                    );
                                  },
                                  text: "Upgrade your links",
                                ),
                              );
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xffDDDDDD)),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: ColorHelper.primary,
                  ),
                ),
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
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        shadowColor: Colors.black.withOpacity(0.3),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: ColorHelper.primary,
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
                        Text(
                          'Rp${nominal}',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '/bulan',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
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
                          'Benefit Pack',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
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
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          BlocConsumer<PaymentBloc, PaymentState>(
                            bloc: _paymentBloc,
                            listener: (context, state) {
                              if (state is PaymentSuccess) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewExample(
                                      url: state
                                          .responsePayment!.data!.urlPayment!,
                                    ),
                                  ),
                                );
                              } else {}
                            },
                            builder: (context, state) {
                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: PrimaryButton(
                                  onPressed: () {
                                    _paymentBloc.add(
                                      PaymentUpgradePaket(
                                        idPaket: idPaket,
                                      ),
                                    );
                                  },
                                  text: "Upgrade your links",
                                ),
                              );
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xffDDDDDD)),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: ColorHelper.primary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

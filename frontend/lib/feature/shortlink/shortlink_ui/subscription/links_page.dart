import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_bloc/handle_api/get_list_url_bloc.dart';

import 'package:flutter_application_singkatin/helper/color_helper.dart';
import 'package:flutter_application_singkatin/helper/resusable_widget/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LinksPage extends StatefulWidget {
  const LinksPage({super.key});

  @override
  State<LinksPage> createState() => _LinksPageState();
}

class _LinksPageState extends State<LinksPage> {
  final _getShortLinkBloc = GetListUrlBloc();

  @override
  void initState() {
    _getShortLinkBloc.add(GetShortUrl());
    super.initState();
  }

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
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: Text(
          "SingkatinAja.id",
          style: GoogleFonts.poppins(
            color: ColorHelper.primary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<GetListUrlBloc, GetListUrlState>(
        bloc: _getShortLinkBloc,
        listener: (context, state) {
          debugPrint('state is $state');
        },
        builder: (context, state) {
          if (state is GetListUrlLoading) {
          } else if (state is GetListUrlSuccess) {
            final getState = state.responseGetListUrl!.data;
            return Column(
              children: [
                Text(
                  "Links",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      itemCount: state.responseGetListUrl!.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getState![index].name!,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        width: 200,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: ColorHelper.primary,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: RichText(
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                            text: TextSpan(
                                              text: getState[index].shortUrl!,
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        getState[index].longUrl!,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: const Color(0xff999999),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '${getState[index].createdAt} by ${getState[index].name}',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            insetPadding:
                                                const EdgeInsets.all(24),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 24),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16.0))),
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
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 0, 16, 16),
                                                child: PrimaryButton(
                                                  onPressed: () async {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LinksPage(),
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
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: const Color(0xffDDDDDD)),
                                        ),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            minimumSize: Size.zero,
                                            padding: EdgeInsets.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          onPressed: () async {
                                            await Clipboard.setData(
                                              ClipboardData(
                                                text: getState[index].shortUrl,
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.copy,
                                            color: ColorHelper.primary,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            );
          } else if (state is GetListUrlError) {}
          return Container();
        },
      ),
    );
  }
}

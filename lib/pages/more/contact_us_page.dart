import 'dart:io';

import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_utils.dart';
import '../../utils/consts.dart';
import '../../utils/patterns.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_form_field.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final _formDialogKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate('contact_us'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: mainColor,
        ),
        body: SingleChildScrollView(
          physics: bouncingScroll,
          child: Padding(
            padding: EdgeInsets.all(
              ScreenUtil().setWidth(16),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width,
                    height: size.height * .3,
                    child: Image.asset(
                      'assets/images/contact_us.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Card(
                    elevation: 6,
                    child: Padding(
                      padding: EdgeInsets.all(
                        ScreenUtil().setWidth(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('contact_us_desc_page'),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Container(
                            height: ScreenUtil().setHeight(160),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppLocalizations.of(context)
                                    .translate('your_msg'),
                              ),
                              controller: _messageController,
                              validator: (String input) {
                                if (input.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .translate('required');
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: size.height * .05,
                          ),
                          MyButton(
                            text:
                                AppLocalizations.of(context).translate('send'),
                            width: ScreenUtil().setWidth(100),
                            height: ScreenUtil().setHeight(45),
                            onTap: showDialogContactUs,
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  showDialogContactUs() {
    if (_formKey.currentState.validate()) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            content: Container(
              child: Form(
                key: _formDialogKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyTextFormField(
                      prefixIcon: Icons.phone,
                      hint: AppLocalizations.of(context).translate('phone'),
                      controller: _phoneController,
                      maxLines: null,
                      keyboardType: TextInputType.number,
                      validator: (String input) {
                        if (input.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate('required');
                        } else if (!MyPatterns.phoneIsValid(input)) {
                          return AppLocalizations.of(context)
                              .translate('enter_valid_phone');
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    MyTextFormField(
                      prefixIcon: Icons.email,
                      hint: AppLocalizations.of(context).translate('email'),
                      keyboardType: TextInputType.emailAddress,
                      maxLines: null,
                      validator: (String input) {
                        if (input.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate('required');
                        } else if (!MyPatterns.emailIsValid(input)) {
                          return AppLocalizations.of(context)
                              .translate('enter_valid_email');
                        } else {
                          return null;
                        }
                      },
                      controller: _emailController,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context).translate('cancel')),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context).translate('send')),
                onPressed: () {
                  validateAndSend();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void validateAndSend() async {
    // valid user input
    if (_formDialogKey.currentState.validate()) {
      // case inputs are true
      // show loading model
      //Loading().loading(context);

      // fill required to with the request

    }
  }
}

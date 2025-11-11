import 'package:espitaliaa_doctors/getx/auth_controller.dart';
import 'package:espitaliaa_doctors/models/user_login_model.dart';
import 'package:espitaliaa_doctors/pages/auth/register_page.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/patterns.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_text_form_field.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hidePassword = true;
  bool _remember_me = true;

  // Text Field  Controller
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final controller = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String _firebaseToken = "";

  @override
  void initState() {
    super.initState();
    getFirebaseToken();
  }

  void getFirebaseToken() async {
    _firebaseToken = await _firebaseMessaging.getToken();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: bouncingScroll,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: size.height * .05,
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('login'),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    wordSpacing: 2,
                    fontSize: 22,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    AppLocalizations.of(context).translate('login_to_continue'),
                    style: const TextStyle(
                      wordSpacing: 2,
                      color: Colors.black38,
                      fontSize: 16,
                    ),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .1,
              ),
              MyTextFormField(
                prefixIcon: Icons.email,
                hint: AppLocalizations.of(context).translate('email'),
                controller: _emailController,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (!MyPatterns.emailIsValid(input)) {
                    return AppLocalizations.of(context)
                        .translate('enter_valid_email');
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: size.height * .015,
              ),
              MyTextFormField(
                prefixIcon: Icons.lock,
                controller: _passwordController,
                obscureText: _hidePassword,
                hint: AppLocalizations.of(context).translate('password'),
                swifixIcon: IconButton(
                  icon: Icon(
                    _hidePassword ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _hidePassword = !_hidePassword;
                    setState(() {});
                  },
                ),
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 6) {
                    return AppLocalizations.of(context)
                        .translate('password_length_msg');
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: size.height * .025,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(18),
                ),
                child: CheckboxListTile(
                  activeColor: mainColor,
                  checkColor: Colors.white,
                  title: Text(
                    AppLocalizations.of(context).translate('remember_me'),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  value: _remember_me,
                  onChanged: (bool val) {
                    _remember_me = !_remember_me;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                height: size.height * .035,
              ),
              MyButton(
                text: AppLocalizations.of(context).translate('login'),
                onTap: () {
                  validateAndLogin();
                },
              ),
              SizedBox(
                height: size.height * .035,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ForgotPasswordPage(),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('forgot_password'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .035,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('have_no_account'),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('register_now'),
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .065,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateAndLogin() {
    AppUtils.hideKeyboard(context);
    if (_formKey.currentState.validate()) {
      UserLoginModel user = new UserLoginModel(
          email: _emailController.text,
          password: _passwordController.text,
          firebaseToken: _firebaseToken,
          rememberMe: _remember_me);
      controller.login(user: user);
    }
  }
}

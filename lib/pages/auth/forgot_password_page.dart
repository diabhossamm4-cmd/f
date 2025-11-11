import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../getx/auth_controller.dart';
import '../../utils/app_utils.dart';
import '../../utils/consts.dart';
import '../../utils/patterns.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_form_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  final bool isOrg;
  ForgotPasswordPage({Key key, this.isOrg}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
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
                  AppLocalizations.of(context).translate("restore_password"),
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
                    AppLocalizations.of(context).translate("enter_phone_to_reset_password"),
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
              SizedBox(
                width: size.width,
                height: size.height * .3,
                child: Image.asset(
                  'assets/images/forget_password.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: size.height * .1,
              ),
              MyTextFormField(
                prefixIcon: Icons.email,
                hint: AppLocalizations.of(context).translate("email"),
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (!MyPatterns.emailIsValid(input)) {
                    return AppLocalizations.of(context).translate('enter_valid_email');
                  } else {
                    return null;
                  }
                },
                controller: _emailController,
              ),
              SizedBox(
                height: size.height * .025,
              ),
              MyButton(
                text: AppLocalizations.of(context).translate("restore_password"),
                onTap: () {
                  validateAndSendCode(context);
                },
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

  void validateAndSendCode(BuildContext context) async {
    // valid user input
    if (_formKey.currentState.validate()) {
      AppUtils.hideKeyboard(context);

      Map<String, String> body = {"email": "${_emailController.text}"};

      await authController.validateEmailToForgetPass(context, body: body, isOrg: widget.isOrg);
      //AppUtils.showToast(msg: result.message);
      //  if (result.statusCode == 200) Navigator.of(context).pop();

    }
  }
}

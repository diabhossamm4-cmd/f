import 'package:espitaliaa_doctors/getx/auth_controller.dart';
import 'package:espitaliaa_doctors/getx/org/auth_org_controller.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/app_utils.dart';
import 'package:espitaliaa_doctors/widgets/my_button.dart';
import 'package:espitaliaa_doctors/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetNewPasswordPage extends StatefulWidget {
  final bool isOrg;
  SetNewPasswordPage({@required this.isOrg});
  @override
  _SetNewPasswordPageState createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  bool _hideOldPassword = true;
  AuthOrgController authOrgController;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newConfirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: size.height * .05,
              ),
              ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('choose_a_strong_password'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    wordSpacing: 2,
                    fontSize: 22,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .15,
              ),
              MyTextFormField(
                prefixIcon: Icons.lock,
                textInputAction: TextInputAction.next,
                obscureText: _hideOldPassword,
                swifixIcon: IconButton(
                  icon: Icon(
                    _hideOldPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    _hideOldPassword = !_hideOldPassword;
                    setState(() {});
                  },
                ),
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 6) {
                    return AppLocalizations.of(context).translate('password_length_msg');
                  } else {
                    return null;
                  }
                },
                controller: oldPasswordController,
                hint: AppLocalizations.of(context).translate('old_password'),
              ),
              SizedBox(
                height: size.height * .015,
              ),
              MyTextFormField(
                prefixIcon: Icons.lock,
                controller: newPasswordController,
                obscureText: _hidePassword,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 6) {
                    return AppLocalizations.of(context).translate('password_length_msg');
                  } else {
                    return null;
                  }
                },
                swifixIcon: IconButton(
                  icon: Icon(_hidePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    _hidePassword = !_hidePassword;
                    setState(() {});
                  },
                ),
                hint: AppLocalizations.of(context).translate('new_password'),
              ),
              SizedBox(
                height: size.height * .015,
              ),
              MyTextFormField(
                prefixIcon: Icons.lock,
                controller: newConfirmPasswordController,
                textInputAction: TextInputAction.done,
                obscureText: _hideConfirmPassword,
                validator: (String input) {
                  if (input.isEmpty) {
                    return AppLocalizations.of(context).translate('required');
                  } else if (input.length < 6) {
                    return AppLocalizations.of(context).translate('password_length_msg');
                  } else {
                    return null;
                  }
                },
                swifixIcon: IconButton(
                  icon: Icon(
                    _hideConfirmPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    _hideConfirmPassword = !_hideConfirmPassword;
                    setState(() {});
                  },
                ),
                hint: AppLocalizations.of(context).translate('password_confirm'),
              ),
              SizedBox(
                height: size.height * .2,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(18),
                    vertical: ScreenUtil().setHeight(12),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: MyButton(
                      borderRadius: 12,
                      width: ScreenUtil().setWidth(120),
                      text: AppLocalizations.of(context).translate('save'),
                      onTap: () {
                        validateForm();
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .02,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void validateForm() async {
    AppUtils.hideKeyboard(context);

    if (_formKey.currentState.validate()) {
      var form = {
        "old_password": "${oldPasswordController.text}",
        "password": "${newPasswordController.text}",
        "password_confirmation": "${newConfirmPasswordController.text}"
      };

      await AuthController().forgetPass(body: form, isOrg: widget.isOrg);
    }
  }
}

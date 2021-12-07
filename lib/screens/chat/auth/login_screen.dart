import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nolavybz/class/custom_loading.dart';
import 'package:nolavybz/helper/authentication_helper.dart';
import 'package:nolavybz/utils/custom_color.dart';
import 'package:nolavybz/utils/dimensions.dart';
import 'package:nolavybz/utils/snackbar/error_snackbar.dart';
import 'package:nolavybz/utils/snackbar/success_snackbar.dart';
import 'package:nolavybz/utils/strings.dart';
import 'package:nolavybz/widgets/button/primary_button_widget.dart';
import 'package:nolavybz/widgets/text_field/input_password_textfield_widget.dart';
import 'package:nolavybz/widgets/text_field/input_textfield_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import '../live_chat_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoginLoading = true;
  bool isRegLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // emailController.text = 'owner@gmail.com';
    // passwordController.text = '12345678';

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CustomColor.secondaryColor,
      appBar: AppBar(
        title: Text(
            Strings.login
        ),
        backgroundColor: CustomColor.primaryColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
            top: Dimensions.heightSize * 2,
        ),
        child: Column(
             children: [
            _inputFiledWidget(context),
            SizedBox(height: Dimensions.heightSize * 2),
            _signInButtonWidget(context),
            SizedBox(height: Dimensions.heightSize * 2),
            Text(
              'OR',
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.largeTextSize
              ),
            ),
            SizedBox(height: Dimensions.heightSize * 2),
            _signUpButtonWidget(context),
          ],
        ),
      ),
    );
  }

  _inputFiledWidget(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputTextFieldWidget(
              controller: emailController,
              title: Strings.email,
              hintText: Strings.enterEmail,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: Dimensions.heightSize,),
            InputPasswordTextFieldWidget(
              controller: passwordController,
              title: Strings.password,
              hintText: Strings.enterPassword,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: Dimensions.heightSize),
          ],
        )
    );
  }

  _signInButtonWidget(BuildContext context) {
    return isLoginLoading ? PrimaryButtonWidget(
      title: Strings.login,
      onTap: () {
        if(formKey.currentState.validate()) {
          setState(() {
            isLoginLoading = false;
          });
          _goToLoginProcess();
        }
      },
    )
        : CustomLoading();
  }

  _signUpButtonWidget(BuildContext context) {
    return isRegLoading ? PrimaryButtonWidget(
      title: Strings.register,
      onTap: () {
        if(formKey.currentState.validate()) {
          setState(() {
            isRegLoading = false;
          });
          _goToRegisterProcess();
        }
      },
    )
        : CustomLoading();
  }

  void _goToLoginProcess() {
    AuthenticationHelper()
        .signIn(email: emailController.text, password: passwordController.text)
        .then((value) {
          if(value == null) {
            setState(() {
              isLoginLoading = true;
            });
            User user = FirebaseAuth.instance.currentUser;
            print('login success: '+user.email);
            successSnackBar(context, 'Login Success');
            _goToLiveChatScreen(context);
          }else {
            setState(() {
              isLoginLoading = true;
            });
            print(value);
            errorSnackBar(context, value);
          }
    });
  }

  void _goToRegisterProcess() {
    AuthenticationHelper()
        .signUp(email: emailController.text, password: passwordController.text)
        .then((value) {
          if(value == null) {
            setState(() {
              isRegLoading = true;
            });
            User user = FirebaseAuth.instance.currentUser;
            print('login success: '+user.email);
            successSnackBar(context, 'Login Success');
            _goToLiveChatScreen(context);
          }else {
            setState(() {
              isRegLoading = true;
            });
            print(value);
            errorSnackBar(context, value);
          }
    });
  }

  void _goToLiveChatScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LiveChatScreen()), (route) => false);
  }

}

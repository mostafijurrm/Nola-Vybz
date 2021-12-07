import 'package:flutter/material.dart';
import 'package:nolavybz/utils/custom_style.dart';
import 'package:nolavybz/utils/dimensions.dart';
import 'package:nolavybz/utils/strings.dart';

class InputTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title, hintText;
  final TextInputType keyboardType;

  const InputTextFieldWidget({Key key, this.controller, this.title, this.hintText, this.keyboardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleData(title),
          TextFormField(
            readOnly: false,
            style: CustomStyle.textStyle,
            controller: controller,
            keyboardType: keyboardType,
            validator: (String value){
              if(value.isEmpty){
                return Strings.pleaseFillOutTheField;
              }else{
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              labelStyle: CustomStyle.textStyle,
              filled: true,
              fillColor: Colors.white,
              hintStyle: CustomStyle.hintTextStyle,
              focusedBorder: CustomStyle.focusBorder,
              enabledBorder: CustomStyle.focusBorder,
              focusedErrorBorder: CustomStyle.focusErrorBorder,
              errorBorder: CustomStyle.focusErrorBorder,
            ),
          ),
        ],
      ),
    );
  }

  _titleData(String title) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimensions.heightSize * 0.5,
        top: Dimensions.heightSize,
      ),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white.withOpacity(0.6)
        ),
      ),
    );
  }
}

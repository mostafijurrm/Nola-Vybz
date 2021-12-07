import 'package:flutter/material.dart';
import 'package:nolavybz/utils/custom_color.dart';
import 'package:nolavybz/utils/custom_style.dart';
import 'package:nolavybz/utils/dimensions.dart';
import 'package:nolavybz/utils/strings.dart';


class InputPasswordTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String title, hintText;
  final TextInputType keyboardType;
  const InputPasswordTextFieldWidget({Key key, this.controller, this.title, this.hintText, this.keyboardType}) : super(key: key);


  @override
  _InputPasswordTextFieldWidgetState createState() => _InputPasswordTextFieldWidgetState();
}

class _InputPasswordTextFieldWidgetState extends State<InputPasswordTextFieldWidget> {

  bool _toggleVisibility = true;

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
          _titleData(widget.title),
          TextFormField(
            style: CustomStyle.textStyle,
            controller: widget.controller,
            validator: (String value){
              if(value.isEmpty){
                return Strings.pleaseFillOutTheField;
              }else{
                return null;
              }
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              labelStyle: CustomStyle.textStyle,
              hintStyle: CustomStyle.hintTextStyle,
              focusedBorder: CustomStyle.focusBorder,
              enabledBorder: CustomStyle.focusBorder,
              focusedErrorBorder: CustomStyle.focusErrorBorder,
              errorBorder: CustomStyle.focusErrorBorder,
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _toggleVisibility = !_toggleVisibility;
                  });
                },
                icon: _toggleVisibility
                    ? Icon(
                  Icons.visibility_off,
                  color: CustomColor.primaryColor.withOpacity(0.5),
                )
                    : Icon(
                  Icons.visibility,
                  color: CustomColor.primaryColor,
                ),
              ),
            ),
            obscureText: _toggleVisibility,
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
            color: Colors.black
        ),
      ),
    );
  }
}

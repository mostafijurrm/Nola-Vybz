import 'package:flutter/material.dart';
import 'package:nolavybz/utils/custom_color.dart';
import 'package:nolavybz/utils/dimensions.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;

  const PrimaryButtonWidget({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius * 0.5))
          ),
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

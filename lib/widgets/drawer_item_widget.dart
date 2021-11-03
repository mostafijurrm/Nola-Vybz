import 'package:flutter/material.dart';
import 'package:nolavybz/utils/custom_color.dart';
import 'package:nolavybz/utils/strings.dart';

class DrawerItemWidget extends StatelessWidget {

  final String title;
  final IconData iconData;
  final GestureTapCallback onTap;

  const DrawerItemWidget({Key key, this.title, this.iconData, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
            iconData,
            color: CustomColor.primaryColor
        ),
        title: Text(
          title,
          style: TextStyle(color: CustomColor.primaryColor),
        ),
        onTap: () {
          if(title != '${Strings.aboutUs}') {
            Navigator.pop(context);
          }
          onTap();
        });
  }
}

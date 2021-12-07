import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nolavybz/class/custom_loading.dart';
import 'package:nolavybz/screens/chat/auth/login_screen.dart';
import 'package:nolavybz/utils/custom_color.dart';
import 'package:nolavybz/utils/dimensions.dart';
import 'package:nolavybz/utils/snackbar/error_snackbar.dart';
import 'package:nolavybz/utils/snackbar/success_snackbar.dart';
import 'package:nolavybz/utils/strings.dart';
import 'package:nolavybz/widgets/text_field/input_textfield_widget.dart';

class LiveChatScreen extends StatefulWidget {


  @override
  _LiveChatScreenState createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {

  final nameController = TextEditingController();
  final messageController = TextEditingController();

  CollectionReference collectionRef = FirebaseFirestore.instance.collection('Chat');

  User user;

  String username = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    user = FirebaseAuth.instance.currentUser;

    // _navigateScreen();
    // _getUsername();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.secondaryColor,
      appBar: AppBar(
        title: Text(
            Strings.liveChat
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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          chatListWidget(context),
          _typeMessageWidget(context),
        ],
      ),
    );
  }

  chatListWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 160.0.h
      ),
      child: StreamBuilder(
        stream: collectionRef.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              reverse: false,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final data = snapshot.data.docs[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.marginSize,
                    right: Dimensions.marginSize,
                    top: Dimensions.heightSize,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius * 2),
                          bottomLeft: Radius.circular(Dimensions.radius * 2),
                          bottomRight: Radius.circular(Dimensions.radius),
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.marginSize * 0.5,
                        right: Dimensions.marginSize * 0.5,
                        top: Dimensions.heightSize,
                        bottom: Dimensions.heightSize,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['username'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.defaultTextSize,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            data['message'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.defaultTextSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return CustomLoading();
        },
      ),
    );
  }

  _typeMessageWidget(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          SizedBox(
            width: 150.w,
            child: InputTextFieldWidget(
              controller: nameController,
              title: 'Your Name',
              hintText: 'write your name',
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: InputTextFieldWidget(
                  controller: messageController,
                  title: 'Write Your Message',
                  hintText: 'type something...',
                ),
              ),
              IconButton(
                  onPressed: () {
                    if(messageController.text.isNotEmpty) {
                      print(user.email);
                      _sentMessageProcess();
                    } else {
                      print('no text');
                      _getUsername();
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                iconSize: 35.0,
              ),
              SizedBox(width: Dimensions.widthSize,)
            ],
          ),
        ],
      ),
    );
  }

  void _navigateScreen() {
    Timer(
        Duration(
            seconds: 0
        ), () => _checkLoggedInUser(context)
    );
  }

  _checkLoggedInUser(BuildContext context) async {
    user = FirebaseAuth.instance.currentUser;

    if(user != null){
      print('chat: ${user.email}');
      successSnackBar(context, 'Logged In');
    } else {
      errorSnackBar(context, 'Please Login/Register First For Do Live Chat');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  _sentMessageProcess() async {
    await collectionRef.add({
      'username': nameController.text == '' ? 'No Name' : nameController.text,
      'message': messageController.text,
    });
    messageController.clear();
    print('message sent success');
  }

  void _getUsername() {
    String email = user.email;
    List list = email.split('@');

    setState(() {
      username = list[0];
    });
    print(username);
  }
}

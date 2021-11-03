import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nolavybz/utils/dimensions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';
import 'package:nolavybz/class/custom_loading.dart';
import 'package:nolavybz/class/url_launcher.dart';
import 'package:nolavybz/model/custom_metadata.dart';
import 'package:nolavybz/services/audio_player_task.dart';
import 'package:nolavybz/services/queue_state.dart';
import 'package:nolavybz/utils/custom_color.dart';
import 'package:nolavybz/utils/strings.dart';
import 'package:nolavybz/widgets/drawer_item_widget.dart';
import 'package:volume_control/volume_control.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  //for volume slider
  double _val = 0.5;
  Timer timer;

  @override
  void initState() {
    super.initState();

    initVolumeState();
    // _play();
    _getMetadata();
  }


  Future<void> initVolumeState() async {
    if (!mounted) return;

    //read the current volume
    _val = await VolumeControl.volume;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    _play();
    return WillPopScope(
        onWillPop: _backPressed,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                  Strings.appName
              ),
              backgroundColor: CustomColor.secondaryColor,
            ),
            drawer: getDrawer(),
            backgroundColor: CustomColor.primaryColor,
            body: AudioServiceWidget(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: CustomColor.primaryColor,
                child: StreamBuilder(
                  stream: AudioService.runningStream,
                  builder: (context, snapshot) {
                    final running = snapshot.data ?? false;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!running) ...[
                          // UI to show when we're not running, i.e. a menu.
                          // if (kIsWeb || !Platform.isMacOS) textToSpeechButton(),
                          Center(
                            child: IconButton(
                                onPressed: () {
                                  _play();
                                },
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 50,
                                )
                            ),
                          )
                        ] else ...[

                          StreamBuilder<QueueState>(
                            stream: _queueStateStream,
                            builder: (context, snapshot) {
                              final queueState = snapshot.data;
                              final queue = queueState?.queue ?? [];
                              final mediaItem = queueState?.mediaItem;
                              return Column(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (mediaItem?.title != null) Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            bottom: 10
                                        ),
                                        child: Image.asset(
                                          'assets/images/icon.png',
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.heightSize,),
                                      Text(
                                        Strings.nowPlaying,
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimensions.largeTextSize
                                        ),
                                        textAlign: TextAlign.center
                                      ),
                                      Slider(
                                          activeColor: Colors.white54,
                                          value: _val,
                                          min:0,
                                          max:1,
                                          divisions: 100,
                                          onChanged:(val){
                                            _val = val;
                                            setState(() {});
                                            if (timer!=null){
                                              timer.cancel();
                                            }

                                            //use timer for the smoother sliding
                                            timer = Timer(Duration(milliseconds: 200), (){VolumeControl.setVolume(val);});

                                            print("val:${val}");
                                          }),
                                      SizedBox(height: 20,)
                                    ],
                                  ) else CustomLoading(),
                                  if (queue.isNotEmpty)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        StreamBuilder<bool>(
                                          stream: AudioService.playbackStateStream
                                              .map((state) => state.playing)
                                              .distinct(),
                                          builder: (context, snapshot) {
                                            final playing = snapshot.data ?? false;
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                if (playing) pauseButton() else playButton(),
                                                // stopButton(),
                                              ],
                                            );
                                          },
                                        ),
                                        /*IconButton(
                                          icon: Icon(
                                            Icons.skip_next,
                                            color: Colors.white,
                                          ),
                                          iconSize: 50.0,
                                          onPressed: mediaItem == queue.last
                                              ? null
                                              : AudioService.skipToNext,
                                        ),*/
                                      ],
                                    ),
                                ],
                              );
                            },
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            )
        )
    );
  }


  IconButton playButton() => IconButton(
    icon: Icon(Icons.play_arrow,
      color: Colors.white,
    ),
    iconSize: 50.0,
    onPressed: AudioService.play,
  );

  IconButton pauseButton() => IconButton(
    icon: Icon(
      Icons.pause,
      color: Colors.white,
    ),
    iconSize: 50.0,
    onPressed: AudioService.pause,
  );

  IconButton stopButton() => IconButton(
    icon: Icon(
      Icons.list,
      color: Colors.white,
    ),
    iconSize: 50.0,
    onPressed: AudioService.stop,
  );

  Stream<QueueState> get _queueStateStream =>
      Rx.combineLatest2<List<MediaItem>, MediaItem, QueueState>(
          AudioService.queueStream,
          AudioService.currentMediaItemStream,
              (queue, mediaItem) => QueueState(queue, mediaItem));

  Future<bool> _backPressed() async {
    return (await showDialog(
      barrierColor: Colors.white,
      context: context,
      builder: (context) => new AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Alert!',
          style: TextStyle(
              color: Colors.red
          ),
        ),
        content: Text(
          'Do you want to exit ${Strings.appName}?',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              AudioService.stop();
              SystemNavigator.pop();
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }


  void _play() async {
    AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
      // androidNotificationChannelName: Strings.songTitle,
      // androidNotificationChannelDescription: Strings.songTitle,
      // Enable this if you want the Android service to exit the foreground state on pause.
      androidStopForegroundOnPause: true,
      androidNotificationColor: 0xFFffffff,
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidEnableQueue: false,
    );
    AudioService.updateMediaItem(MediaItem(
        id: Strings.radioUrl,
        album: Strings.appName,
        title: Strings.songTitle
    ));
  }

  Drawer getDrawer() {
    return Drawer(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/icon.png',
                  ),
                ),
              ),
              DrawerItemWidget(
                title: Strings.facebook,
                iconData: FontAwesomeIcons.facebook,
                onTap: () {
                  UrlLauncher.url(Strings.facebookUrl);
                },
              ),
              DrawerItemWidget(
                title: Strings.website,
                iconData: FontAwesomeIcons.chrome,
                onTap: () {
                  UrlLauncher.url(Strings.webUrl);
                },
              ),
              DrawerItemWidget(
                title: Strings.instagram,
                iconData: FontAwesomeIcons.instagram,
                onTap: () {
                  UrlLauncher.url(Strings.instaUrl);
                },
              ),
              DrawerItemWidget(
                title: Strings.twitter,
                iconData: FontAwesomeIcons.twitter,
                onTap: () {
                  UrlLauncher.url(Strings.twitterUrl);
                },
              ),
              DrawerItemWidget(
                title: Strings.youTube,
                iconData: FontAwesomeIcons.youtube,
                onTap: () {
                  UrlLauncher.url(Strings.youTubeUrl);
                },
              ),
              DrawerItemWidget(
                title: Strings.share,
                iconData: FontAwesomeIcons.share,
                onTap: () {
                  if (Platform.isAndroid) {
                    Share.share('I am listening to-\n'
                        '${Strings.appName}\n'
                        '${Strings.androidAppUrl}');
                  } else {
                    Share.share('I am listening to-\n'
                        '${Strings.appName}\n'
                        '${Strings.iosAppUrl}');
                  }
                },
              ),
              DrawerItemWidget(
                title: Strings.email,
                iconData: FontAwesomeIcons.mailBulk,
                onTap: () {
                  UrlLauncher.url(Strings.emailAddress);
                },
              ),
              DrawerItemWidget(
                title: Strings.aboutUs,
                iconData: FontAwesomeIcons.infoCircle,
                onTap: () {
                  _showDetails();
                },
              ),
              DrawerItemWidget(
                title: Strings.rateApp,
                iconData: FontAwesomeIcons.star,
                onTap: () {
                  if(Platform.isAndroid) {
                    UrlLauncher.url(Strings.androidAppUrl);
                  } else if (Platform.isIOS) {
                    UrlLauncher.url(Strings.iosAppUrl);
                  }
                },
              ),
            ],
          )),
    );
  }

  Future<bool> _showDetails() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text(
          'Welcome to '+Strings.appName,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                Strings.aboutUsDetails,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('OK'),
          ),
        ],
      ),
    )) ?? false;
  }
  
  Future<CustomMetadata> _getMetadata() async {
    Uri url = Uri.parse('https://stream.upfm.live/api/nowplaying');

    final response = await http.get(url);
    var data = jsonDecode(response.body);

    setState(() {
      Strings.songTitle = data[0]['now_playing']['song']['text'];
    });
    // print(Strings.songTitle);
    return CustomMetadata.fromJson(data);
  }

}

void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
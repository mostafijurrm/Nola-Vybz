import 'package:audio_service/audio_service.dart';
import 'package:nolavybz/utils/strings.dart';

class RadioLibrary {


  final _items = <MediaItem>[
    MediaItem(
      // This can be any unique id, but we use the audio URL for convenience.
      id: Strings.radioUrl,
      album: Strings.appName,
      title: Strings.appName,
      // artist: Strings.appName,
      duration: Duration(milliseconds: 0),
      artUri: 'assets/images/icon.png',
    )
  ];

  List<MediaItem> get items => _items;
}
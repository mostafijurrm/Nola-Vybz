class CustomMetadata {
  Station station;
  Listeners listeners;
  Live live;
  NowPlaying nowPlaying;
  PlayingNext playingNext;
  List<SongHistory> songHistory;
  bool isOnline;
  String cache;

  CustomMetadata(
      {this.station,
        this.listeners,
        this.live,
        this.nowPlaying,
        this.playingNext,
        this.songHistory,
        this.isOnline,
        this.cache});

  CustomMetadata.fromJson(Map<String, dynamic> json) {
    station =
    json['station'] != null ? new Station.fromJson(json['station']) : null;
    listeners = json['listeners'] != null
        ? new Listeners.fromJson(json['listeners'])
        : null;
    live = json['live'] != null ? new Live.fromJson(json['live']) : null;
    nowPlaying = json['now_playing'] != null
        ? new NowPlaying.fromJson(json['now_playing'])
        : null;
    playingNext = json['playing_next'] != null
        ? new PlayingNext.fromJson(json['playing_next'])
        : null;
    if (json['song_history'] != null) {
      songHistory = new List<SongHistory>();
      json['song_history'].forEach((v) {
        songHistory.add(new SongHistory.fromJson(v));
      });
    }
    isOnline = json['is_online'];
    cache = json['cache'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.station != null) {
      data['station'] = this.station.toJson();
    }
    if (this.listeners != null) {
      data['listeners'] = this.listeners.toJson();
    }
    if (this.live != null) {
      data['live'] = this.live.toJson();
    }
    if (this.nowPlaying != null) {
      data['now_playing'] = this.nowPlaying.toJson();
    }
    if (this.playingNext != null) {
      data['playing_next'] = this.playingNext.toJson();
    }
    if (this.songHistory != null) {
      data['song_history'] = this.songHistory.map((v) => v.toJson()).toList();
    }
    data['is_online'] = this.isOnline;
    data['cache'] = this.cache;
    return data;
  }
}

class Station {
  int id;
  String name;
  String shortcode;
  String description;
  String frontend;
  String backend;
  String listenUrl;
  String url;
  String publicPlayerUrl;
  String playlistPlsUrl;
  String playlistM3uUrl;
  bool isPublic;
  List<Mounts> mounts;
  List<Null> remotes;

  Station(
      {this.id,
        this.name,
        this.shortcode,
        this.description,
        this.frontend,
        this.backend,
        this.listenUrl,
        this.url,
        this.publicPlayerUrl,
        this.playlistPlsUrl,
        this.playlistM3uUrl,
        this.isPublic,
        this.mounts,
        this.remotes});

  Station.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortcode = json['shortcode'];
    description = json['description'];
    frontend = json['frontend'];
    backend = json['backend'];
    listenUrl = json['listen_url'];
    url = json['url'];
    publicPlayerUrl = json['public_player_url'];
    playlistPlsUrl = json['playlist_pls_url'];
    playlistM3uUrl = json['playlist_m3u_url'];
    isPublic = json['is_public'];
    if (json['mounts'] != null) {
      mounts = new List<Mounts>();
      json['mounts'].forEach((v) {
        mounts.add(new Mounts.fromJson(v));
      });
    }
    if (json['remotes'] != null) {
      remotes = new List<Null>();
      json['remotes'].forEach((v) {
        // remotes.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortcode'] = this.shortcode;
    data['description'] = this.description;
    data['frontend'] = this.frontend;
    data['backend'] = this.backend;
    data['listen_url'] = this.listenUrl;
    data['url'] = this.url;
    data['public_player_url'] = this.publicPlayerUrl;
    data['playlist_pls_url'] = this.playlistPlsUrl;
    data['playlist_m3u_url'] = this.playlistM3uUrl;
    data['is_public'] = this.isPublic;
    if (this.mounts != null) {
      data['mounts'] = this.mounts.map((v) => v.toJson()).toList();
    }
    if (this.remotes != null) {
      // data['remotes'] = this.remotes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mounts {
  String path;
  bool isDefault;
  int id;
  String name;
  String url;
  int bitrate;
  String format;
  Listeners listeners;

  Mounts(
      {this.path,
        this.isDefault,
        this.id,
        this.name,
        this.url,
        this.bitrate,
        this.format,
        this.listeners});

  Mounts.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    isDefault = json['is_default'];
    id = json['id'];
    name = json['name'];
    url = json['url'];
    bitrate = json['bitrate'];
    format = json['format'];
    listeners = json['listeners'] != null
        ? new Listeners.fromJson(json['listeners'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['is_default'] = this.isDefault;
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    data['bitrate'] = this.bitrate;
    data['format'] = this.format;
    if (this.listeners != null) {
      data['listeners'] = this.listeners.toJson();
    }
    return data;
  }
}

class Listeners {
  int total;
  int unique;
  int current;

  Listeners({this.total, this.unique, this.current});

  Listeners.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    unique = json['unique'];
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['unique'] = this.unique;
    data['current'] = this.current;
    return data;
  }
}

class Live {
  bool isLive;
  String streamerName;
  Null broadcastStart;

  Live({this.isLive, this.streamerName, this.broadcastStart});

  Live.fromJson(Map<String, dynamic> json) {
    isLive = json['is_live'];
    streamerName = json['streamer_name'];
    broadcastStart = json['broadcast_start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_live'] = this.isLive;
    data['streamer_name'] = this.streamerName;
    data['broadcast_start'] = this.broadcastStart;
    return data;
  }
}

class NowPlaying {
  int elapsed;
  int remaining;
  int shId;
  int playedAt;
  int duration;
  String playlist;
  String streamer;
  bool isRequest;
  Song song;

  NowPlaying(
      {this.elapsed,
        this.remaining,
        this.shId,
        this.playedAt,
        this.duration,
        this.playlist,
        this.streamer,
        this.isRequest,
        this.song});

  NowPlaying.fromJson(Map<String, dynamic> json) {
    elapsed = json['elapsed'];
    remaining = json['remaining'];
    shId = json['sh_id'];
    playedAt = json['played_at'];
    duration = json['duration'];
    playlist = json['playlist'];
    streamer = json['streamer'];
    isRequest = json['is_request'];
    song = json['song'] != null ? new Song.fromJson(json['song']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['elapsed'] = this.elapsed;
    data['remaining'] = this.remaining;
    data['sh_id'] = this.shId;
    data['played_at'] = this.playedAt;
    data['duration'] = this.duration;
    data['playlist'] = this.playlist;
    data['streamer'] = this.streamer;
    data['is_request'] = this.isRequest;
    if (this.song != null) {
      data['song'] = this.song.toJson();
    }
    return data;
  }
}

class Song {
  String id;
  String text;
  String artist;
  String title;
  String album;
  String genre;
  String lyrics;
  String art;
  List<Null> customFields;

  Song(
      {this.id,
        this.text,
        this.artist,
        this.title,
        this.album,
        this.genre,
        this.lyrics,
        this.art,
        this.customFields});

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    artist = json['artist'];
    title = json['title'];
    album = json['album'];
    genre = json['genre'];
    lyrics = json['lyrics'];
    art = json['art'];
    if (json['custom_fields'] != null) {
      customFields = new List<Null>();
      json['custom_fields'].forEach((v) {
        // customFields.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['artist'] = this.artist;
    data['title'] = this.title;
    data['album'] = this.album;
    data['genre'] = this.genre;
    data['lyrics'] = this.lyrics;
    data['art'] = this.art;
    if (this.customFields != null) {
      // data['custom_fields'] = this.customFields.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayingNext {
  int cuedAt;
  int duration;
  String playlist;
  bool isRequest;
  Song song;

  PlayingNext(
      {this.cuedAt, this.duration, this.playlist, this.isRequest, this.song});

  PlayingNext.fromJson(Map<String, dynamic> json) {
    cuedAt = json['cued_at'];
    duration = json['duration'];
    playlist = json['playlist'];
    isRequest = json['is_request'];
    song = json['song'] != null ? new Song.fromJson(json['song']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cued_at'] = this.cuedAt;
    data['duration'] = this.duration;
    data['playlist'] = this.playlist;
    data['is_request'] = this.isRequest;
    if (this.song != null) {
      data['song'] = this.song.toJson();
    }
    return data;
  }
}

class SongHistory {
  int shId;
  int playedAt;
  int duration;
  String playlist;
  String streamer;
  bool isRequest;
  Song song;

  SongHistory(
      {this.shId,
        this.playedAt,
        this.duration,
        this.playlist,
        this.streamer,
        this.isRequest,
        this.song});

  SongHistory.fromJson(Map<String, dynamic> json) {
    shId = json['sh_id'];
    playedAt = json['played_at'];
    duration = json['duration'];
    playlist = json['playlist'];
    streamer = json['streamer'];
    isRequest = json['is_request'];
    song = json['song'] != null ? new Song.fromJson(json['song']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sh_id'] = this.shId;
    data['played_at'] = this.playedAt;
    data['duration'] = this.duration;
    data['playlist'] = this.playlist;
    data['streamer'] = this.streamer;
    data['is_request'] = this.isRequest;
    if (this.song != null) {
      data['song'] = this.song.toJson();
    }
    return data;
  }
}

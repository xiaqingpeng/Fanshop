
class Log {
  
  late final String desc;
  late final String path;
  // ignore: non_constant_identifier_names
  late final String time;
  late final String platform;
  // ignore: non_constant_identifier_names
  late final String environment;
  late final String handler;
  late final String id;

  Log({
   
    // ignore: non_constant_identifier_names
    required this.desc,
    required this.path,
    // ignore: non_constant_identifier_names
    required this.time,
    // ignore: non_constant_identifier_names
    required this.platform,
    // ignore: non_constant_identifier_names
    required this.environment,
    // ignore: non_constant_identifier_names
    required this.handler,
    // ignore: non_constant_identifier_names
    required this.id,
  });
  static List<Log> fromJson(Map json) {
    // ignore: avoid_print

    List<Log> _log = [];

    // JsonDecoder decoder = const JsonDecoder();
    // var mapData = decoder.convert(json);
    var mapData = json['res']['data'];

    mapData.forEach((obj) {
      Log logs = Log(
        desc: obj['desc'],
        time: obj['time'],
        path: obj['path'],
        platform: obj['platform'],
        environment: obj['environment'],
        handler: obj['handler'],
        id: obj['_id'],
      );
      _log.add(logs);
    });
    return _log;
  }
}
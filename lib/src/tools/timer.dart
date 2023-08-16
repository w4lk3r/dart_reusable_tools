part of '../devsdocs_reusable_tools_base.dart';

class TimeTools {
  factory TimeTools() => _instance ??= TimeTools._internal();
  TimeTools._internal();
  static TimeTools? _instance;

  /// Always returning time in positive(+) value of [second]
  String timerDisplay(int second) {
    final int weeks = second ~/ 604800;
    final int days = (second ~/ 86400) % 7;
    final int hours = (second ~/ 3600) % 24;
    final int minutes = (second ~/ 60) % 60;
    final int seconds = second % 60;

    final weeksString = '$weeks ${weeks == 1 ? 'week' : 'weeks'}';
    final daysString = '$days ${days == 1 ? 'day' : 'days'}';
    final hoursString = '$hours ${hours == 1 ? 'hour' : 'hours'}';
    final minutesString = '$minutes ${minutes == 1 ? 'minute' : 'minutes'}';
    final secondsString = '$seconds ${seconds <= 1 ? 'second' : 'seconds'}';

    if (weeks > 0) {
      return [weeksString, hoursString, minutesString, secondsString].join(':');
    } else if (days > 0) {
      return [daysString, hoursString, minutesString, secondsString].join(':');
    } else if (hours > 0) {
      return [hoursString, minutesString, secondsString].join(':');
    } else if (minutes > 0) {
      return [minutesString, secondsString].join(':');
    } else if (second >= 0) {
      return secondsString;
    } else {
      return timerDisplay(second.abs());
    }
  }
}

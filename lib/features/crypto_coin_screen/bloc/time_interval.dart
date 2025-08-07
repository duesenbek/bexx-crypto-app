part of 'crypto_coin_bloc.dart';// time_interval.dart
enum TimeInterval {
  thirtyMinutes,
  oneHour,
  twentyFourHours,
  sevenDays,
  thirtyDays,
}

extension TimeIntervalExtension on TimeInterval {
  String get label {
    switch (this) {
      case TimeInterval.thirtyMinutes:
        return '30 Minutes';
      case TimeInterval.oneHour:
        return '1 Hour';
      case TimeInterval.twentyFourHours:
        return '24 Hours';
      case TimeInterval.sevenDays:
        return '7 Days';
      case TimeInterval.thirtyDays:
        return '30 Days';
    }
  }
}
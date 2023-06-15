import 'package:flutter_riverpod/flutter_riverpod.dart';

enum City {
  mekkah,
  cairo,
  alex,
}

typedef WeatherEmoji = String;
Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
      const Duration(seconds: 1),
      () =>
          {
            City.mekkah: '☀️',
            City.cairo: '☁️',
            City.alex: '🌧️',
          }[city] ??
          '?');
}

const unknownWeatherEmoji = '🤷';

// UI Writes to this provider and reads from this
final currentCityProvider = StateProvider<City?>((ref) => null);

// Ui Reads this to know what to display

final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(currentCityProvider);
  if (city != null) {
    return getWeather(city);
  } else {
    return unknownWeatherEmoji;
  }
});

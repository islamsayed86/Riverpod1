// ignore_for_file: deprecated_member_use

import 'package:flutter_riverpod/flutter_riverpod.dart';

const names = [
  'Alice',
  'Pop',
  'Charli',
  'David',
  'Eve',
  'Frid',
  'Gerry',
  'Harry',
  'Ileana',
  'Larry',
  'Parry',
  'Gharry',
];
final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(
      milliseconds: 500,
    ),
    (x) => x + 1,
  ),
);
final namesProvider = StreamProvider(
  (ref) => ref.watch(tickerProvider.stream).map(
        (count) => names.getRange(0, count),
      ),
);

import 'package:chrono_dart/chrono_dart.dart' show Chrono;
import 'package:chrono_dart/src/types.dart';

void main() {
  // Russian
  final rusDateOrNull = Chrono.parseDate('Встреча 12 сентября');
  print('Found date: $rusDateOrNull');

  final rusResults = Chrono.parse('Встреча 12 сентября');
  print('Found dates: $rusResults');

  final dateOrNull = Chrono.parseDate(
    '03/01',
    ref: DateTime(2025, 12, 01),
    option: ParsingOption(forwardDate: true)
  );
  print('Found date: $dateOrNull');
}
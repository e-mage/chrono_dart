import 'package:chrono_dart/chrono_dart.dart' show Chrono;
import 'package:chrono_dart/src/types.dart';

void main() {
  // Russian
  final rusDateOrNull = Chrono.parseDate('Встреча 12 сентября');
  print('Found date: $rusDateOrNull');

  var rusResults = Chrono.parse('Встреча 12 сентября');
  print('Found dates: $rusResults');

  // Other russian examples

  // Parse DD/MM of the current year
  // !!!Warning!!! Parsing DD.MM - doesn't work. You need to replace DD.MM -> DD/MM before parsing.
  var dateOrNull = Chrono.parseDate('03/01');
  print ('Parse DD/MM of the current year: "03/01" - $dateOrNull');

  // Parse DD/MM forward, since some date
  dateOrNull = Chrono.parseDate(
    '03/01',
    ref: DateTime(2025, 12, 01),
    option: ParsingOption(forwardDate: true)
  );
  print('Parse DD/MM since 2025-12-01: "03/01" - $dateOrNull');

  // Parse DD.MM.YY | DD.MM.YYYY | DD/MM/YY | DD/MM/YYYY
  dateOrNull = Chrono.parseDate('03/01/25');
  print ('Parse DD/MM/YY: "03/01/25 - $dateOrNull');

  // Parse "29 ноября"
  dateOrNull = Chrono.parseDate('29 ноября');
  print ('Parse "29 of November" of the current year: "29 ноября" - $dateOrNull');

  // Parse "29 ноя"
  dateOrNull = Chrono.parseDate('29 ноя');
  print ('Parse "29 of Nov" of the current year: "29 ноя" - $dateOrNull');

  // Parse "29 ноября 2026"
  dateOrNull = Chrono.parseDate('29 ноября 2026');
  print ('Parse "29 of November 2026" of the current year: "29 ноября 2026" - $dateOrNull');

  // Parse "следующее воскресенье", since some date
  dateOrNull = Chrono.parseDate(
    'в следующее воскресенье',
    ref: DateTime(2025, 12, 01),
    option: ParsingOption(forwardDate: true)
  );
  print('Parse "next sunday" since 2025-12-01: "следующее воскресенье" - $dateOrNull');

  // Parse "вчера"
  dateOrNull = Chrono.parseDate('вчера');
  print ('Parse "yesterday": "вчера" - $dateOrNull');

  // Parse "26 ноября - 1 декабря"
  dateOrNull = Chrono.parseDate('26 ноября - 1 декабря');
  print('Parse "26 of november - 1 of december" - "26 ноября - 1 декабря": $dateOrNull');
}
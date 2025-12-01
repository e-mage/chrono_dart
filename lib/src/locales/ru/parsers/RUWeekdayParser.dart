// ignore_for_file: constant_identifier_names
import '../../../types.dart';
import '../../../chrono.dart' show ParsingContext;
import '../../../results.dart' show ParsingComponents;
import '../constants.dart' show WEEKDAY_DICTIONARY;
import '../../../utils/pattern.dart' show matchAnyPattern;
import '../../../common/parsers/AbstractParserWithWordBoundary.dart'
    show AbstractParserWithWordBoundaryChecking;
import '../../../common/calculation/weekdays.dart'
    show createParsingComponentsAtWeekday;

final _pattern = RegExp(
  // ignore: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation
  "(?:(?:\\,|\\(|\\（)\\s*)?" +
      "(?:в\\s*?)?" +
      "(?:(эту|этот|это|прошлый|прошлую|прошлое|следующий|следующую|следующего|следующее)\\s*)?" +
      "(${matchAnyPattern(WEEKDAY_DICTIONARY)})" +
      "(?:\\s*(?:\\,|\\)|\\）))?" +
      "(?:\\s*на\\s*(этой|прошлой|следующей)\\s*неделе)?" +
      "(?=\\W|\$)",
  caseSensitive: false,
);

const _PREFIX_GROUP = 1;
const _WEEKDAY_GROUP = 2;
const _POSTFIX_GROUP = 3;

class RUWeekdayParser extends AbstractParserWithWordBoundaryChecking {
  @override
  RegExp innerPattern(context) {
    return _pattern;
  }

  @override
  ParsingComponents innerExtract(
      ParsingContext context, RegExpChronoMatch match) {
    final dayOfWeek = match[_WEEKDAY_GROUP]!.toLowerCase();

    /// TODO: remove assumed weekday if null
    final weekday = Weekday.weekById(WEEKDAY_DICTIONARY[dayOfWeek] ?? 0);
    final prefix = match[_PREFIX_GROUP];
    final postfix = match[_POSTFIX_GROUP];
    var modifierWord = prefix ?? postfix;
    modifierWord = modifierWord ?? "";
    modifierWord = modifierWord.toLowerCase();

    String? modifier;
    if (modifierWord == "прошлый" || modifierWord == "прошлую" || modifierWord == "прошлой" || modifierWord == "прошлое") {
      modifier = "last";
    } else if (modifierWord == "следующий" || modifierWord == "следующую" || modifierWord == "следующей" || modifierWord == "следующего" || modifierWord == "следующее") {
      modifier = "next";
    } else if (modifierWord == "этот" || modifierWord == "эту" || modifierWord == "этой" || modifierWord == "это") {
      modifier = "this";
    }

    return createParsingComponentsAtWeekday(
        context.reference, weekday, modifier);
  }
}

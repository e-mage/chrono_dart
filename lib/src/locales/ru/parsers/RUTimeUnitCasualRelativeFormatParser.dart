import '../../../chrono.dart' show ParsingContext;
import '../../../types.dart' show RegExpChronoMatch;
import '../constants.dart'
    show TIME_UNITS_PATTERN, parseTimeUnits, TIME_UNITS_NO_ABBR_PATTERN;
import '../../../results.dart' show ParsingComponents;
import '../../../common/parsers/AbstractParserWithWordBoundary.dart';
import "../../../utils/timeunits.dart" show reverseTimeUnits;

final _pattern = RegExp(
    "(эти|последние|прошлые|следующие|после|спустя|через|\\+|-)\\s*($TIME_UNITS_PATTERN)(?=\\W|\$)",
    caseSensitive: false);
final _patternNoAbbr = RegExp(
  "(эти|последние|прошлые|следующие|после|спустя|через|\\+|-)\\s*($TIME_UNITS_NO_ABBR_PATTERN)(?=\\W|\$)",
  caseSensitive: false,
);

class RUTimeUnitCasualRelativeFormatParser
    extends AbstractParserWithWordBoundaryChecking {
  final bool allowAbbreviations;

  RUTimeUnitCasualRelativeFormatParser([this.allowAbbreviations = true])
      : super();

  @override
  RegExp innerPattern(context) {
    return allowAbbreviations ? _pattern : _patternNoAbbr;
  }

  @override
  ParsingComponents innerExtract(
      ParsingContext context, RegExpChronoMatch match) {
    final prefix = match[1]!.toLowerCase();
    var timeUnits = parseTimeUnits(match[2]!);
    switch (prefix) {
      case "последние":
      case "прошлые":
      case "-":
        timeUnits = reverseTimeUnits(timeUnits);
        break;
    }

    return ParsingComponents.createRelativeFromReference(
        context.reference, timeUnits);
  }
}

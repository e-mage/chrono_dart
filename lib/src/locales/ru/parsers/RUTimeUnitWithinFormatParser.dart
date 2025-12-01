// ignore_for_file: prefer_adjacent_string_concatenation, non_constant_identifier_names
import '../constants.dart'
    show TIME_UNITS_PATTERN, parseTimeUnits, TIME_UNITS_NO_ABBR_PATTERN;
import '../../../chrono.dart' show ParsingContext;
import '../../../results.dart' show ParsingComponents;
import '../../../types.dart' show RegExpChronoMatch;
import '../../../common/parsers/AbstractParserWithWordBoundary.dart';

final PATTERN_WITH_OPTIONAL_PREFIX = RegExp(
    "(?:(?:около|примерно)\\s*(?:~\\s*)?)?($TIME_UNITS_PATTERN)(?=\\W|\$)",
    caseSensitive: false);

final PATTERN_WITH_PREFIX = RegExp(
    "(?:в течение|в течении)\\s*(?:(?:около|примерно)\\s*(?:~\\s*)?)?($TIME_UNITS_PATTERN)(?=\\W|\$)",
    caseSensitive: false);

final PATTERN_WITH_PREFIX_STRICT = RegExp(
    "(?:в течение|в течении)\\s*(?:(?:около|примерно)\\s*(?:~\\s*)?)?($TIME_UNITS_NO_ABBR_PATTERN)(?=\\W|\$)",
    caseSensitive: false);

class RUTimeUnitWithinFormatParser
    extends AbstractParserWithWordBoundaryChecking {
  final bool _strictMode;

  RUTimeUnitWithinFormatParser(bool strictMode)
      : _strictMode = strictMode,
        super();

  @override
  RegExp innerPattern(ParsingContext context) {
    if (_strictMode) {
      return PATTERN_WITH_PREFIX_STRICT;
    }
    return context.option.forwardDate != null
        ? PATTERN_WITH_OPTIONAL_PREFIX
        : PATTERN_WITH_PREFIX;
  }

  @override
  ParsingComponents innerExtract(
      ParsingContext context, RegExpChronoMatch match) {
    final timeUnits = parseTimeUnits(match[1]!);
    return ParsingComponents.createRelativeFromReference(
        context.reference, timeUnits);
  }
}

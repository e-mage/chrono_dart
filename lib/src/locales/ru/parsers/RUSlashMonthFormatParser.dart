import '../../../chrono.dart' show ParsingContext;
import '../../../results.dart' show ParsingComponents;
import '../../../types.dart' show Component, RegExpChronoMatch;
import '../../../common/parsers/AbstractParserWithWordBoundary.dart';

//final _PATTERN = RegExp(r'([0-9]|0[1-9]|1[012])/([0-9]{4})');
final _PATTERN = RegExp(r'((0?[1-9]|[12][0-9]|3[01]))[/.-]([0-9]|0[1-9]|1[012])');

const _DAY_GROUP = 1;
const _MONTH_GROUP = 2;

/// x Month/Year date format with slash "/" (also "-" and ".") between numbers
/// x - 11/05
/// x - 06/2005
/// - В русском варианте это будет DD/MM
class RUSlashMonthFormatParser extends AbstractParserWithWordBoundaryChecking {
  @override
  RegExp innerPattern(context) {
    return _PATTERN;
  }

  @override
  ParsingComponents innerExtract(ParsingContext context, RegExpChronoMatch match) {
    final day = int.tryParse(match[_DAY_GROUP]!)!;
    final month = int.tryParse(match[_MONTH_GROUP]!)!;

    return context
        .createParsingComponents()
        .imply(Component.day, day)
        .assign(Component.month, month);
        //.assign(Component.year, year);
  }
}

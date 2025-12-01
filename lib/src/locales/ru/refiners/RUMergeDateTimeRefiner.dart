import '../../../common/refiners/AbstractMergeDateTimeRefiner.dart';

/// Merging date-only result and time-only result (see. AbstractMergeDateTimeRefiner).
/// This implementation should provide English connecting phases
/// - 2020-02-13 [at] 6pm
/// - Tomorrow [after] 7am
/// - 2020-02-13 [в] 6:00
/// - Завтра [,] 7:00
class RUMergeDateTimeRefiner extends AbstractMergeDateTimeRefiner {
  @override
  RegExp patternBetween() {
    return RegExp(r'^\s*(T|в|,|-)?\s*$', caseSensitive: false);
  }
}

import '../../../common/refiners/AbstractMergeDateRangeRefiner.dart';

/// Merging before and after results (see. AbstractMergeDateRangeRefiner)
/// This implementation should provide English connecting phases
/// - 2020-02-13 [to] 2020-02-13
/// - Wednesday [-] Friday
/// - c 06.09.1989 [до|по] 11.12.1996
/// - c пятницы и до среды
class RUMergeDateRangeRefiner extends AbstractMergeDateRangeRefiner {
  @override
  RegExp patternBetween() {
    return RegExp(r'^\s*(и до|и по|до|по|-)\s*$', caseSensitive: false);
  }
}

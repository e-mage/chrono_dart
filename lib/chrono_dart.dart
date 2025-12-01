/// Date parser for user-generated text. https://github.com/g-30/chrono_dart
library;

import './src/chrono.dart' show ChronoInstance;
import './src/locales/ru/ru.dart' as ru;
import './src/types.dart' show ParsedResult, ParsingOption, ParsingReference;

export './src/chrono.dart';
export './src/types.dart';
export './src/results.dart';

abstract class Chrono {
  /// A shortcut for {@link en | chrono.en.strict}
  static final strict = ru.strict;

  /// A shortcut for {@link en | chrono.en.casual}
  static final casual = ru.casual;

  /// Default instance with en.casual config.
  static final instance = ChronoInstance();

  /// A shortcut for {@link en | chrono.en.casual.parse()}
  static List<ParsedResult> parse(String text,
      {dynamic ref, ParsingOption? option}) {
    assert(ref == null || ref is ParsingReference || ref is DateTime,
        'ref must be either null, DateTime or ParsingReference');
    return casual.parse(text, ref, option);
  }

  /// A shortcut for {@link en | chrono.en.casual.parseDate()}
  static DateTime? parseDate(String text,
      {dynamic ref, ParsingOption? option}) {
    assert(ref == null || ref is ParsingReference || ref is DateTime,
        'ref must be either null, DateTime or ParsingReference');
    return casual.parseDate(text, ref, option);
  }
}

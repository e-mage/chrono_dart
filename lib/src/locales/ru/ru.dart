/// Chrono components for English support (*parsers*, *refiners*, and *configuration*)
///
/// @module

import '../../../chrono_dart.dart' show ChronoInstance;
import '../../types.dart' show ParsedResult, ParsingOption;

import './configuration.dart';

final ruConfig = RUDefaultConfiguration();

/// Chrono object configured for parsing *casual* Russian
final casual = ChronoInstance(ruConfig.createCasualConfiguration(true));

/// ChronoInstance object configured for parsing *strict* Russian
final strict = ChronoInstance(ruConfig.createConfiguration(true, true));

/// ChronoInstance object configured for parsing *UK-style* English
//final GB = ChronoInstance(ruConfig.createConfiguration(false, true));

/// A shortcut for ru.casual.parse()
List<ParsedResult> parse(String text, [DateTime? ref, ParsingOption? option]) {
  return casual.parse(text, ref, option);
}

/// A shortcut for ru.casual.parseDate()
DateTime? parseDate(String text, DateTime ref, ParsingOption option) {
  return casual.parseDate(text, ref, option);
}

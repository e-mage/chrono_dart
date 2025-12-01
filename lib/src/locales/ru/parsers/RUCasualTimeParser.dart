// ignore_for_file: library_prefixes
import '../../../results.dart' show ParsingComponents;
import '../../../chrono.dart' show ParsingContext;
import '../../../types.dart' show RegExpChronoMatch;
import '../../../common/parsers/AbstractParserWithWordBoundary.dart';
import '../../../common/casual_references.dart' as casualReferences;

final _pattern = RegExp(
    r'(сейчас|прошлым\s*вечером|прошлой\s*ночью|следующей\s*ночью|сегодня\s*ночью|этой\s*ночью|ночью|этим утром|утром|утра|в\s*полдень|вечером|вечера|в\s*полночь)(?=\W|$)',
    caseSensitive: false);

class RUCasualTimeParser extends AbstractParserWithWordBoundaryChecking {
  @override
  innerPattern(context) {
    return _pattern;
  }

  @override
  innerExtract(ParsingContext context, RegExpChronoMatch match) {
    ParsingComponents? component;
    switch (match[1]!.toLowerCase()) {
      case "сейчас":
        component = casualReferences.now(context.reference);
        break;
      case "прошлым вечером":
        component = casualReferences.yesterdayEvening(context.reference);
        break;
      case "вечером":
      case "вечера":
        component = casualReferences.evening(context.reference);
        break;
      case "прошлой ночью":
        component = casualReferences.lastNight(context.reference);
        break;
      case "утром":
      case "утра":
      case "этим утром":
        component = casualReferences.morning(context.reference);
        break;
      case "в полдень":
        component = casualReferences.noon(context.reference);
        break;
      case "в полночь":
      case "ночью":
      case "этой ночью":
        component = casualReferences.midnight(context.reference);
        break;
    }
    if (component != null) {
      component.addTag("parser/RUCasualTimeParser");
    }
    return component;
  }
}

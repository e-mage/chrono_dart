//import 'package:day/day.dart' as dayjs;
import '../../../chrono.dart' show ParsingContext;
import '../../../types.dart' show RegExpChronoMatch; //, Component;
import '../../../common/parsers/AbstractParserWithWordBoundary.dart';
//import '../../../utils/day.dart' show assignSimilarDate;
import '../../../common/casual_references.dart' as references;

final _pattern = RegExp(
    r'(сейчас|сегодня|вчера|завтра|послезавтра|послепослезавтра|позапозавчера|позавчера)(?=\W|$)',
    caseSensitive: false);

class RUCasualDateParser extends AbstractParserWithWordBoundaryChecking {
  @override
  RegExp innerPattern(ParsingContext context) {
    return _pattern;
  }

  /// @returns ParsingComponents | ParsingResult
  @override
  innerExtract(ParsingContext context, RegExpChronoMatch match) {
    //var targetDate = dayjs.Day.fromDateTime(context.reference.instant);
    final lowerText = match[0]!.toLowerCase();
    var component = context.createParsingComponents();

    switch (lowerText) {
      case "сейчас":
        component = references.now(context.reference);
        break;

      case "сегодня":
        component = references.today(context.reference);
        break;

      case "вчера":
        component = references.yesterday(context.reference);
        break;

      case "завтра":
        component = references.tomorrow(context.reference);
        break;

      case "послезавтра":
        component = references.theDayAfter(context.reference, 2);
        break;

      case "послепослезавтра":
        component = references.theDayAfter(context.reference, 3);
        break;

      case "позавчера":
        component = references.theDayBefore(context.reference, 2);
        break;

      case "позапозавчера":
        component = references.theDayBefore(context.reference, 3);
        break;

    }
    component.addTag("parser/ENCasualDateParser");
    return component;
  }
}

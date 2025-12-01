import '../../chrono.dart' show Configuration;

import './parsers/RUTimeUnitWithinFormatParser.dart';
import './parsers/RUMonthNameLittleEndianParser.dart';
import './parsers/RUMonthNameParser.dart';
import './parsers/RUTimeExpressionParser.dart';
import './parsers/RUTimeUnitAgoFormatParser.dart';

import './refiners/RUMergeDateRangeRefiner.dart';
import './refiners/RUMergeDateTimeRefiner.dart';

import '../../configurations.dart' show includeCommonConfiguration;
import './parsers/RUCasualDateParser.dart';
import './parsers/RUCasualTimeParser.dart';
import './parsers/RUWeekdayParser.dart';
import './parsers/RURelativeDateFormatParser.dart';

import '../../common/parsers/SlashDateFormatParser.dart';
import './parsers/RUTimeUnitCasualRelativeFormatParser.dart';

class RUDefaultConfiguration {
  const RUDefaultConfiguration();

    /// Create a default *casual* {@Link Configuration} for English chrono.
    /// It calls {@Link createConfiguration} and includes additional parsers.
    Configuration createCasualConfiguration([ bool littleEndian = false ]) {
        final option = createConfiguration(false, littleEndian);
        option.parsers.insert(0, RUCasualDateParser());
        option.parsers.insert(0, RUCasualTimeParser());
        option.parsers.insert(0, RUMonthNameParser());
        option.parsers.insert(0, RURelativeDateFormatParser());
        option.parsers.insert(0, RUTimeUnitCasualRelativeFormatParser());
        return option;
    }

    /// Create a default {@Link Configuration} for English chrono
    ///
    /// @param strictMode If the timeunit mentioning should be strict, not casual
    /// @param littleEndian If format should be date-first/littleEndian (e.g. en_UK), not month-first/middleEndian (e.g. en_US)
    Configuration createConfiguration([ bool strictMode = true, bool littleEndian = false ]) {
        final options = includeCommonConfiguration(
            Configuration(
                parsers: [
                    SlashDateFormatParser(littleEndian),
                    RUTimeUnitWithinFormatParser(strictMode),
                    RUMonthNameLittleEndianParser(),
                    RUWeekdayParser(),
                    RUTimeExpressionParser(strictMode),
                    RUTimeUnitAgoFormatParser(strictMode),
                ],
                refiners: [RUMergeDateRangeRefiner(), RUMergeDateTimeRefiner()],
            ),
            strictMode
        );
        // Re-apply the date time refiner again after the timezone refinement and exclusion in common refiners.
        options.refiners.add(RUMergeDateTimeRefiner());
        // Keep the date range refiner at the end (after all other refinements).
        options.refiners.add(RUMergeDateRangeRefiner());
        return options;
    }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker_flutter_course/app/home/job_entries/format.dart';

void main() {
  group('hours', () {
    test('positive', () {
      expect(Format.hours(10), '10h');
    });

    test("zero", () {
      expect(Format.hours(0), '0h');
    });

    test('negative', () {
      expect(Format.hours(-5), '0h');
    });
    test('decimal', () {
      expect(Format.hours(4.5), '4.5h');
    });
  });

  group('date - GB Locale', () {
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });

    test('2020-03-12', () {
      expect(Format.date(DateTime(2020, 3, 12)), '12 Mar 2020');
    });

    test('2020-03-22', () {
      expect(Format.date(DateTime(2020, 3, 22)), '22 Mar 2020');
    });
  });
}

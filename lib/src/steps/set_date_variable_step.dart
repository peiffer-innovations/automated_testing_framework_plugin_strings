import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:intl/intl.dart';
import 'package:json_class/json_class.dart';

class SetDateVariableStep extends TestRunnerStep {
  SetDateVariableStep({
    required this.date,
    required this.format,
    required this.offsetDays,
    required this.offsetHours,
    required this.offsetMinutes,
    required this.offsetSeconds,
    this.utc,
    required this.variableName,
  });

  static const String id = 'set_date_variable';

  static List<String> get behaviorDrivenDescriptions => List.unmodifiable([
        'set the current date time to the `{{variableName}}` variable using the `{{format}}` format in `{{utc}}` timezone.',
        'set `{{date}}`` as the date time to the `{{variableName}}` variable using the `{{format}}` format in `{{utc}}` timezone.',
        'set the current date time, with the offset of: `{{offsetDays}}`, `{{offsetHours}}` hours, `{{offsetMinutes}}` minutes, and `{{offsetSeconds}}` seconds to the `{{variableName}}` variable using the `{{format}}` format in `{{utc}}` timezone.',
        'set `{{date}}``, with the offset of: `{{offsetDays}}`, `{{offsetHours}}` hours, `{{offsetMinutes}}` minutes, and `{{offsetSeconds}}` seconds as the date time to the `{{variableName}}` variable using the `{{format}}` format in `{{utc}}` timezone.',
      ]);

  /// The date to use.  Will be [DateTime.now] when omitted.  This must be
  /// either a variable reference to a [DateTime], an int or string encoded UTC
  /// Millis, or UTC formatted using either of the two formats:
  ///
  /// * `yyyy-MM-dd'T'HH:mm:ss'Z'`
  /// * `yyyy-MM-dd'T'HH:mm:ss.SSS'Z'`
  final String? date;

  /// The output format to use.
  final String format;

  final int offsetDays;
  final int offsetHours;
  final int offsetMinutes;
  final int offsetSeconds;

  /// Set to [true] to leave the emitted [DateTime] in UTC.  Set to [false] or
  /// `null` to convert the [DateTime] to the local timezone before setting the
  /// variable.
  final bool? utc;

  /// The variable name of the variable to set on the controller.
  final String? variableName;

  @override
  String get stepId => id;

  /// Creates an instance from a JSON-like map structure.  This expects the
  /// following format:
  ///
  /// ```json
  /// {
  ///   "date": <String>,
  ///   "format": <String>,
  ///   "offsetDays": <int>,
  ///   "offsetHours": <int>,
  ///   "offsetMinutes": <int>,
  ///   "offsetSeconds": <int>,
  ///   "utc": <bool>,
  ///   "variableName": <String>
  /// }
  /// ```
  static SetDateVariableStep fromDynamic(dynamic map) {
    SetDateVariableStep result;

    if (map == null) {
      throw Exception('[SetDateVariableStep.fromDynamic]: map is null');
    } else {
      result = SetDateVariableStep(
        date: map['date']?.toString(),
        format: map['format'],
        offsetDays: JsonClass.parseInt(map['offsetDays'], 0)!,
        offsetHours: JsonClass.parseInt(map['offsetHours'], 0)!,
        offsetMinutes: JsonClass.parseInt(map['offsetMinutes'], 0)!,
        offsetSeconds: JsonClass.parseInt(map['offsetSeconds'], 0)!,
        utc: JsonClass.parseBool(map['utc']),
        variableName: map['variableName'],
      );
    }

    return result;
  }

  /// Sets the formatted date to a variable on the [TestController].
  @override
  Future<void> execute({
    required CancelToken cancelToken,
    required TestReport report,
    required TestController tester,
  }) async {
    final date = tester.resolveVariable(this.date);
    final format = tester.resolveVariable(this.format);
    final variableName = tester.resolveVariable(this.variableName) ?? '_date';

    assert(format?.isNotEmpty == true);
    assert(variableName.isNotEmpty == true);

    final name = "$id('$variableName', '$date', '$format')";
    log(
      name,
      tester: tester,
    );

    DateTime dateTime;
    if (date == null || (date is String && date.isNotEmpty != true)) {
      dateTime = DateTime.now();
    } else if (date is DateTime) {
      dateTime = date.toUtc();
    } else if (date is int) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(
        date,
        isUtc: true,
      );
    } else if (date is String) {
      if (date.contains('T') == true) {
        try {
          dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(
            date,
            true,
          );
        } catch (e) {
          dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(
            date,
            true,
          );
        }
      } else {
        dateTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(date),
          isUtc: true,
        );
      }
    } else {
      throw Exception('Unknown type for date: [$date]');
    }

    dateTime = DateTime.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch +
            Duration(
                    days: offsetDays,
                    hours: offsetHours,
                    minutes: offsetMinutes,
                    seconds: offsetSeconds)
                .inMilliseconds);

    if (utc != true) {
      dateTime = dateTime.toLocal();
    }

    tester.setTestVariable(
      variableName: variableName,
      value: DateFormat(format).format(dateTime),
    );
  }

  @override
  String getBehaviorDrivenDescription(TestController tester) {
    final hasOffset = offsetDays != 0 ||
        offsetHours != 0 ||
        offsetMinutes != 0 ||
        offsetSeconds != 0;

    var result = hasOffset == true
        ? (date == null
            ? behaviorDrivenDescriptions[2]
            : behaviorDrivenDescriptions[3])
        : date == null
            ? behaviorDrivenDescriptions[0]
            : behaviorDrivenDescriptions[1];

    result = result.replaceAll('{{date}}', date ?? 'null');
    result = result.replaceAll('{{format}}', format);
    result = result.replaceAll('{{offsetDays}}', offsetDays.toString());
    result = result.replaceAll('{{offsetHours}}', offsetHours.toString());
    result = result.replaceAll('{{offsetMinutes}}', offsetMinutes.toString());
    result = result.replaceAll('{{offsetSeconds}}', offsetSeconds.toString());
    result = result.replaceAll('{{utc}}', utc == true ? 'utc' : 'local');
    result = result.replaceAll('{{variableName}}', variableName ?? '_date');

    return result;
  }

  /// Overidden to ignore the delay
  @override
  Future<void> preStepSleep(Duration duration) async {}

  /// Overidden to ignore the delay
  @override
  Future<void> postStepSleep(Duration duration) async {}

  /// Converts this to a JSON compatible map.  For a description of the format,
  /// see [fromDynamic].
  @override
  Map<String, dynamic> toJson() => {
        'date': date,
        'format': format,
        'offsetDays': offsetDays,
        'offsetHours': offsetHours,
        'offsetMinutes': offsetMinutes,
        'offsetSeconds': offsetSeconds,
        'utc': utc,
        'variableName': variableName,
      };
}

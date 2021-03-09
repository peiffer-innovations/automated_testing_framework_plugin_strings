import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:intl/intl.dart';
import 'package:json_class/json_class.dart';

class SetDateVariableStep extends TestRunnerStep {
  SetDateVariableStep({
    required this.date,
    required this.format,
    this.utc,
    required this.variableName,
  });

  /// The date to use.  Will be [DateTime.now] when omitted.  This must be
  /// either a variable reference to a [DateTime], an int or string encoded UTC
  /// Millis, or UTC formatted using either of the two formats:
  ///
  /// * `yyyy-MM-dd'T'HH:mm:ss'Z'`
  /// * `yyyy-MM-dd'T'HH:mm:ss.SSS'Z'`
  final String? date;

  /// The output format to use.
  final String format;

  /// Set to [true] to leave the emitted [DateTime] in UTC.  Set to [false] or
  /// [null] to convert the [DateTime] to the local timezone before setting the
  /// variable.
  final bool? utc;

  /// The variable name of the variable to set on the controller.
  final String? variableName;

  /// Creates an instance from a JSON-like map structure.  This expects the
  /// following format:
  ///
  /// ```json
  /// {
  ///   "date": <String>,
  ///   "format": <String>,
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
    var date = tester.resolveVariable(this.date);
    String? format = tester.resolveVariable(this.format);
    String variableName = tester.resolveVariable(this.variableName) ?? '_date';

    assert(format?.isNotEmpty == true);
    assert(variableName.isNotEmpty == true);

    var name = "set_date_variable('$variableName', '$date', '$format')";
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
        dateTime = DateTime.fromMicrosecondsSinceEpoch(
          int.parse(date),
          isUtc: true,
        );
      }
    } else {
      throw Exception('Unknown type for date: [$date]');
    }

    if (utc != true) {
      dateTime = dateTime.toLocal();
    }

    tester.setVariable(
      variableName: variableName,
      value: DateFormat(format).format(dateTime),
    );
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
        'utc': utc,
        'variableName': variableName,
      };
}

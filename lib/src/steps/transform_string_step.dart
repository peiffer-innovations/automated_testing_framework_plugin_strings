import 'package:automated_testing_framework/automated_testing_framework.dart';

/// Transforms the value in [variableName] to be either fully uppercase or
/// lowercase depending on [mode].
class TransformStringStep extends TestRunnerStep {
  TransformStringStep({
    required this.mode,
    required this.variableName,
  });

  static const id = 'transform_string';

  static List<String> get behaviorDrivenDescriptions => List.unmodifiable([
        'transform the string inside the `{{variableName}}` variable to `{{mode}}`.',
      ]);

  /// Set to "uppercase" to transform the string held in [variableName] to
  /// uppercase.  Set to "lowercase" to transform the string held in
  /// [variableName] to lowercase.  Any other value will result in an error.
  final String mode;

  /// The variable name of the variable to set on the controller.
  final String? variableName;

  @override
  String get stepId => id;

  /// Creates an instance from a JSON-like map structure.  This expects the
  /// following format:
  ///
  /// ```json
  /// {
  ///   "mode": <String>,
  ///   "variableName": <String>
  /// }
  /// ```
  static TransformStringStep fromDynamic(dynamic map) {
    TransformStringStep result;

    if (map == null) {
      throw Exception('[TransformStringStep.fromDynamic]: map is null');
    } else {
      result = TransformStringStep(
        mode: map['mode'],
        variableName: map['variableName'],
      );
    }

    return result;
  }

  /// Sets the variable on the [TestController].
  @override
  Future<void> execute({
    required CancelToken cancelToken,
    required TestReport report,
    required TestController tester,
  }) async {
    final mode = tester.resolveVariable(this.mode)?.toString().toLowerCase();
    final variableName =
        tester.resolveVariable(this.variableName) ?? '_transform';

    assert(mode?.isNotEmpty == true);
    assert(mode == 'lowercase' || mode == 'uppercase');
    assert(variableName.isNotEmpty == true);

    final name = "transform_string('$variableName', '$mode')";
    log(
      name,
      tester: tester,
    );

    var result = tester.resolveVariable('{{$variableName}}')?.toString();
    switch (mode) {
      case 'lowercase':
        result = result?.toLowerCase();
        break;

      case 'uppercase':
        result = result?.toUpperCase();
        break;

      default:
        throw Exception('Unknown transformation mode: [$mode]');
    }

    tester.setTestVariable(
      variableName: variableName,
      value: result,
    );
  }

  @override
  String getBehaviorDrivenDescription(TestController tester) {
    var result = behaviorDrivenDescriptions[0];

    result = result.replaceAll('{{mode}}', mode);
    result =
        result.replaceAll('{{variableName}}', variableName ?? '_transform');

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
        'mode': mode,
        'variableName': variableName,
      };
}

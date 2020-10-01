import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Transforms the value in [variableName] to be either fully uppercase or
/// lowercase depending on [mode].
class TransformStringStep extends TestRunnerStep {
  TransformStringStep({
    @required this.mode,
    @required this.variableName,
  })  : assert(mode != null),
        assert(variableName?.isNotEmpty == true);

  /// Set to "uppercase" to transform the string held in [variableName] to
  /// uppercase.  Set to "lowercase" to transform the string held in
  /// [variableName] to lowercase.  Any other value will result in an error.
  final String mode;

  /// The variable name of the variable to set on the controller.
  final String variableName;

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

    if (map != null) {
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
    @required TestReport report,
    @required TestController tester,
  }) async {
    var mode = tester.resolveVariable(this.mode)?.toString()?.toLowerCase();
    String variableName = tester.resolveVariable(this.variableName);

    assert(mode?.isNotEmpty == true);
    assert(mode == 'lowercase' || mode == 'uppercase');
    assert(variableName?.isNotEmpty == true);

    var name = "transform_string('$variableName', '$mode')";
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

    tester.setVariable(
      variableName: variableName,
      value: result,
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
        'mode': mode,
        'variableName': variableName,
      };
}

import 'package:automated_testing_framework/automated_testing_framework.dart';

/// Test step that will search for a given [regEx] inside an [input] string and
/// will set [variableName] with the first match.
class SubstringVariableStep extends TestRunnerStep {
  SubstringVariableStep({
    required this.input,
    required this.regEx,
    required this.variableName,
  });

  static const id = 'substring_variable';

  static List<String> get behaviorDrivenDescriptions => List.unmodifiable([
        'search the input `{{input}}` for the `{{regEx}}` regular expression and sets the contents of the match to the `{{variableName}}` variable.',
      ]);

  /// The input string to search.
  final String input;

  /// The regular expression to search for in the [input] string.
  final String regEx;

  /// The variable name of the variable to set on the controller.
  final String? variableName;

  @override
  String get stepId => id;

  /// Creates an instance from a JSON-like map structure.  This expects the
  /// following format:
  ///
  /// ```json
  /// {
  ///   "input": <String>,
  ///   "regEx": <String>,
  ///   "variableName": <String>
  /// }
  /// ```
  static SubstringVariableStep fromDynamic(dynamic map) {
    SubstringVariableStep result;

    if (map == null) {
      throw Exception('[SubstringVariableStep.fromDynamic]: map is null');
    } else {
      result = SubstringVariableStep(
        input: map['input'],
        regEx: map['regEx'],
        variableName: map['variableName'],
      );
    }

    return result;
  }

  /// Searches the [input] string for the [regEx] and will set the first match
  /// match in [variableName]
  @override
  Future<void> execute({
    required CancelToken cancelToken,
    required TestReport report,
    required TestController tester,
  }) async {
    var input = tester.resolveVariable(this.input)?.toString();
    var regEx = tester.resolveVariable(this.regEx)?.toString();
    var variableName =
        tester.resolveVariable(this.variableName) ?? '_substring';

    assert(input?.isNotEmpty == true);
    assert(regEx?.isNotEmpty == true);
    assert(variableName?.isNotEmpty == true);

    var name = "$id('$variableName', '$input', '$regEx')";
    log(
      name,
      tester: tester,
    );

    var regExp = RegExp(regEx!);
    var match = regExp.firstMatch(input!);

    String? result;
    if (match != null) {
      if (match.groupCount >= 1) {
        result = match.group(1);
      } else {
        result = match.group(0);
      }
    }

    if (result == null) {
      throw Exception(
          '$id: No match in [$input] found for the pattern: [$regEx].');
    }

    tester.setVariable(
      variableName: variableName,
      value: result,
    );
  }

  @override
  String getBehaviorDrivenDescription(TestController tester) {
    var result = behaviorDrivenDescriptions[0];

    result = result.replaceAll('{{inout}}', input);
    result = result.replaceAll('{{regEx}}', regEx);
    result = result.replaceAll(
      '{{variableName}}',
      variableName ?? '_substring',
    );

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
        'input': input,
        'regEx': regEx,
        'variableName': variableName,
      };
}

import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_strings/automated_testing_framework_plugin_strings.dart';

class TestStringsHelper {
  /// Registers the test steps to the optional [registry].  If not set, the
  /// default [TestStepRegistry] will be used.
  static void registerTestSteps([TestStepRegistry registry]) {
    (registry ?? TestStepRegistry.instance).registerCustomSteps([
      TestStepBuilder(
        availableTestStep: AvailableTestStep(
          form: SetDateVariableForm(),
          help: TestStringsTranslations.atf_strings_help_set_date_variable,
          id: 'set_date_variable',
          keys: const {'date', 'format', 'utc', 'variableName'},
          quickAddValues: null,
          title: TestStringsTranslations.atf_strings_title_set_date_variable,
          widgetless: true,
          type: null,
        ),
        testRunnerStepBuilder: SetDateVariableStep.fromDynamic,
      ),
      TestStepBuilder(
        availableTestStep: AvailableTestStep(
          form: SubstringVariableForm(),
          help: TestStringsTranslations.atf_strings_help_substring_variable,
          id: 'substring_variable',
          keys: const {'input', 'regEx', 'variableName'},
          quickAddValues: null,
          title: TestStringsTranslations.atf_strings_title_substring_variable,
          widgetless: true,
          type: null,
        ),
        testRunnerStepBuilder: SubstringVariableStep.fromDynamic,
      ),
      TestStepBuilder(
        availableTestStep: AvailableTestStep(
          form: TransformStringForm(),
          help: TestStringsTranslations.atf_strings_help_transform_string,
          id: 'transform_string',
          keys: const {'mode', 'variableName'},
          quickAddValues: null,
          title: TestStringsTranslations.atf_strings_title_transform_string,
          widgetless: true,
          type: null,
        ),
        testRunnerStepBuilder: TransformStringStep.fromDynamic,
      ),
    ]);
  }
}

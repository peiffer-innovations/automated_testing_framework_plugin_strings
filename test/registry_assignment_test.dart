import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_strings/automated_testing_framework_plugin_strings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('set_date_variable', () {
    TestStringsHelper.registerTestSteps();
    final availStep = TestStepRegistry.instance.getAvailableTestStep(
      'set_date_variable',
    )!;

    expect(availStep.form.runtimeType, SetDateVariableForm);
    expect(
      availStep.help,
      TestStringsTranslations.atf_strings_help_set_date_variable,
    );
    expect(availStep.id, 'set_date_variable');
    expect(
      availStep.title,
      TestStringsTranslations.atf_strings_title_set_date_variable,
    );
    expect(availStep.type, null);
    expect(availStep.widgetless, true);
  });

  test('substring_variable', () {
    TestStringsHelper.registerTestSteps();
    final availStep = TestStepRegistry.instance.getAvailableTestStep(
      'substring_variable',
    )!;

    expect(availStep.form.runtimeType, SubstringVariableForm);
    expect(
      availStep.help,
      TestStringsTranslations.atf_strings_help_substring_variable,
    );
    expect(availStep.id, 'substring_variable');
    expect(
      availStep.title,
      TestStringsTranslations.atf_strings_title_substring_variable,
    );
    expect(availStep.type, null);
    expect(availStep.widgetless, true);
  });

  test('transform_string', () {
    TestStringsHelper.registerTestSteps();
    final availStep = TestStepRegistry.instance.getAvailableTestStep(
      'transform_string',
    )!;

    expect(availStep.form.runtimeType, TransformStringForm);
    expect(
      availStep.help,
      TestStringsTranslations.atf_strings_help_transform_string,
    );
    expect(availStep.id, 'transform_string');
    expect(
      availStep.title,
      TestStringsTranslations.atf_strings_title_transform_string,
    );
    expect(availStep.type, null);
    expect(availStep.widgetless, true);
  });
}

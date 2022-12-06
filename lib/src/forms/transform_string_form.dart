import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_strings/automated_testing_framework_plugin_strings.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:static_translations/static_translations.dart';

class TransformStringForm extends TestStepForm {
  const TransformStringForm();

  @override
  bool get supportsMinified => true;

  @override
  TranslationEntry get title =>
      TestStringsTranslations.atf_strings_title_transform_string;

  @override
  Widget buildForm(
    BuildContext context,
    Map<String, dynamic>? values, {
    bool minify = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (minify != true)
          buildHelpSection(
            context,
            TestStringsTranslations.atf_strings_help_transform_string,
            minify: minify,
          ),
        buildValuesSection(
          context,
          [
            buildDropdown(
              context: context,
              id: 'mode',
              items: [
                'lowercase',
                'uppercase',
              ],
              label: TestStringsTranslations.atf_strings_form_transform_mode,
              validators: [RequiredValidator()],
              values: values!,
            ),
            const SizedBox(height: 16.0),
            buildEditText(
              context: context,
              id: 'variableName',
              label: TestStepTranslations.atf_form_variable_name,
              validators: [
                RequiredValidator(),
              ],
              values: values,
            ),
          ],
          minify: minify,
        ),
      ],
    );
  }
}

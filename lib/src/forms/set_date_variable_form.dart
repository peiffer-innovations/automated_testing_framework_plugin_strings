import 'package:automated_testing_framework/automated_testing_framework.dart';
import 'package:automated_testing_framework_plugin_strings/automated_testing_framework_plugin_strings.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:intl/intl.dart';
import 'package:static_translations/static_translations.dart';

class SetDateVariableForm extends TestStepForm {
  const SetDateVariableForm();

  @override
  bool get supportsMinified => true;

  @override
  TranslationEntry get title =>
      TestStringsTranslations.atf_strings_title_set_date_variable;

  @override
  Widget buildForm(
    BuildContext context,
    Map<String, dynamic> values, {
    bool minify = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (minify != true)
          buildHelpSection(
            context,
            TestStringsTranslations.atf_strings_help_set_date_variable,
            minify: minify,
          ),
        buildValuesSection(
          context,
          [
            buildEditText(
              context: context,
              id: 'variableName',
              label: TestStepTranslations.atf_form_variable_name,
              values: values,
            ),
            SizedBox(height: 16.0),
            buildEditText(
              context: context,
              id: 'date',
              label: TestStringsTranslations.atf_strings_form_date,
              validators: [
                _DateValidator(),
              ],
              values: values,
            ),
            SizedBox(height: 16.0),
            buildEditText(
              context: context,
              id: 'format',
              label: TestStringsTranslations.atf_strings_form_format,
              values: values,
            ),
            SizedBox(height: 16.0),
            buildDropdown(
              context: context,
              defaultValue: 'false',
              id: 'utc',
              items: [
                'true',
                'false',
              ],
              label: TestStringsTranslations.atf_strings_form_utc,
              values: values,
            ),
          ],
          minify: minify,
        ),
      ],
    );
  }
}

class _DateValidator extends ValueValidator {
  @override
  String validate({
    String label,
    Translator translator,
    String value,
  }) {
    String error;

    if (value?.isNotEmpty == true) {
      DateTime dateTime;
      try {
        try {
          dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(value));
        } catch (e) {
          // no-op
        }

        if (dateTime == null) {
          try {
            dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(value);
          } catch (e) {
            // no-op
          }
        }

        if (dateTime == null) {
          try {
            dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(value);
          } catch (e) {
            // no-op
          }
        }

        if (dateTime == null) {
          throw Exception('No date time');
        }
      } catch (e) {
        error = translator.translate(
          TestStringsTranslations.atf_strings_error_date,
        );
      }
    }

    return error;
  }

  @override
  Map<String, dynamic> toJson() => {};
}

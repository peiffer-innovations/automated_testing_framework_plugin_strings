import 'package:static_translations/static_translations.dart';

class TestStringsTranslations {
  static const atf_strings_error_date = TranslationEntry(
    key: 'atf_strings_error_date',
    value: 'Date is invalid',
  );

  static const atf_strings_form_date = TranslationEntry(
    key: 'atf_strings_form_date',
    value: 'Date',
  );

  static const atf_strings_form_format = TranslationEntry(
    key: 'atf_strings_form_format',
    value: 'Format',
  );

  static const atf_strings_form_transform_mode = TranslationEntry(
    key: 'atf_strings_form_transform_mode',
    value: 'Mode',
  );

  static const atf_strings_form_utc = TranslationEntry(
    key: 'atf_strings_form_utc',
    value: 'UTC',
  );

  static const atf_strings_help_set_date_variable = TranslationEntry(
    key: 'atf_strings_help_set_date_variable',
    value:
        'Sets a variable with a formatted date using the given format.  The value can be formatted using either UTC or Local time.  If the date is left empty, the current date / time will be used.  Otherwise, it must be either UTC Millis or formatted as "yyyy-MM-dd\'T\'HH:mm:ss\'Z\'" or "yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'".',
  );

  static const atf_strings_help_transform_string = TranslationEntry(
    key: 'atf_strings_help_transform_string',
    value: 'Transforms a string held in a variable ',
  );

  static const atf_strings_title_set_date_variable = TranslationEntry(
    key: 'atf_strings_title_set_date_variable',
    value: 'Set Date Variable',
  );

  static const atf_strings_title_transform_string = TranslationEntry(
    key: 'atf_strings_title_transform_string',
    value: 'Transform String',
  );
}

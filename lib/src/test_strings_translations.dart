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

  static const atf_strings_form_input = TranslationEntry(
    key: 'atf_strings_form_input',
    value: 'Input',
  );

  static const atf_strings_form_reg_ex = TranslationEntry(
    key: 'atf_strings_form_reg_ex',
    value: 'RegEx',
  );

  static const atf_strings_form_offset_days = TranslationEntry(
    key: 'atf_strings_form_offset_days',
    value: 'Offset in Days',
  );

  static const atf_strings_form_offset_hours = TranslationEntry(
    key: 'atf_strings_form_offset_hours',
    value: 'Offset in Hours',
  );

  static const atf_strings_form_offset_minutes = TranslationEntry(
    key: 'atf_strings_form_offset_minutes',
    value: 'Offset in Minutes',
  );

  static const atf_strings_form_offset_seconds = TranslationEntry(
    key: 'atf_strings_form_offset_seconds',
    value: 'Offset in Seconds',
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

  static const atf_strings_help_substring_variable = TranslationEntry(
    key: 'atf_strings_help_substring_variable',
    value:
        'Sets a variable name with a RegEx match from the given input string.  If the RegEx has at least one group, the value of the first matched group will be used rather than the value of the overall match.  Finally, if no match is found, this will fail.',
  );

  static const atf_strings_help_transform_string = TranslationEntry(
    key: 'atf_strings_help_transform_string',
    value: 'Transforms a string held in a variable ',
  );

  static const atf_strings_title_set_date_variable = TranslationEntry(
    key: 'atf_strings_title_set_date_variable',
    value: 'Set Date Variable',
  );

  static const atf_strings_title_substring_variable = TranslationEntry(
    key: 'atf_strings_title_substring_variable',
    value: 'Substring Variable',
  );

  static const atf_strings_title_transform_string = TranslationEntry(
    key: 'atf_strings_title_transform_string',
    value: 'Transform String',
  );
}

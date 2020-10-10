# Test Steps

## Table of Contents

* [Introduction](#introduction)
* [Test Step Summary](#test-step-summary)
* [Details](#details)
  * [set_date_variable](#set_date_variable)
  * [substring_variable](#substring_variable)
  * [transform_string](#transform_string)

## Introduction

This plugin provides a [Test Steps](https://github.com/peiffer-innovations/automated_testing_framework/blob/main/documentation/STEPS.md) related to string formatting and manipulation.


---

## Test Step Summary

Test Step IDs                             | Description
------------------------------------------|-------------
[set_date_variable](#set_date_variable)   | Sets a `DateTime` to a formatted string value in the named `variableName`.
[substring_variable](#substring_variable) | Searches for a `regEx` in an `input` and sets the resulting match into `variableName`.
[transform_string](#transform_string)     | Transforms the string set in `variableName` to uppercase or lowercase.


---

## Details

### set_date_variable

**How it Works**

1. Clears all logs from the current `TestReport`.


**Example**

```json
{
  "id": "set_date_variable",
  "image": "<optional_base_64_image>",
  "values": {
    "date": "2020-01-01T12:00:00Z",
    "format": "yyyy-MM-dd",
    "utc": false,
    "variableName": "formattedDate"
  }
}
```

**Values**

Key            | Type   | Required | Supports Variable | Description
---------------|--------|----------|-------------------|-------------
`date`         | String | No       | Yes               | The date value.  If a variable is used, this can be a `DateTime`, an `int` that represents UTC Millis, or it can be directly a string formatted as either: `yyyy-MM-dd'T'HH:mm:ss'Z'` or `yyyy-MM-dd'T'HH:mm:ss.SSS'Z'`.  If omitted, this will default to `DateTime.now()`.
`format`       | String | Yes      | Yes               | The format to apply to the `date`.
`utc`          | bool   | No       | Yes               | Set to `true` to write the formatted date in UTC.  Set to `false` to write it out in the device's local time zone.  Defaults to `false`.
`variableName` | String | No       | Yes               | The variable name to write the formatted date string to.  Defaults to `_date` if omitted.

---

### substring_variable

**How it Works**

1. Searches the given `input` for the `regEx`; fails if no match is found.
2. If the `regEx` has a group in it, the value from the first group is set to `variableName`, otherwise the entire pattern match is set to `variableName`.


**Example**

```json
{
  "id": "substring_variable",
  "image": "<optional_base_64_image>",
  "values": {
    "input": "input string to use",
    "regEx": "_(\\d+)",
    "variableName": "variableToSave"
  }
}
```

**Values**

Key            | Type   | Required | Supports Variable | Description
---------------|--------|----------|-------------------|-------------
`input`        | String | Yes      | Yes               | The input string to search.
`regEx`        | String | Yes      | Yes               | The Regular Expression to search the `input` for.  If the regular expression contains a group, the match from the first group will be utilized.  Otherwise the match from the entire expression will be used.
`variableName` | String | No       | Yes               | The name of the variable to store the substring; will be `_substring` if not explicitly set


---

### transform_string

**How it Works**

1. Locates the variable defined in `variableName`.
2. Converts it to `uppercase` or `lowercase` depending on the `mode`.


**Example**

```json
{
  "id": "transform_string",
  "image": "<optional_base_64_image>",
  "values": {
    "mode": "uppercase",
    "variableName": "variableToTransform"
  }
}
```

**Values**

Key            | Type   | Required | Supports Variable | Description
---------------|--------|----------|-------------------|-------------
`mode`         | String | Yes      | Yes               | The mode to use when transforming the string.  Must be either "uppercase" or "lowercase".
`variableName` | String | Yes      | Yes               | The name of the variable in which the string should be transformed.

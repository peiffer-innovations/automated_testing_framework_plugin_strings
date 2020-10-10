# automated_testing_framework_plugin_strings

## Table of Contents

* [Introduction](#introduction)
* [Additional Test Steps](https://github.com/peiffer-innovations/automated_testing_framework_plugin_strings/blob/main/documentation/STEPS.md)
* [Supported Platforms](#supported-platforms)
* [Reserved Variables](#reserved-variables)


## Introduction

This plugin provides test steps that allow for string generation and manipulation.


## Supported Platforms

This has been tested on Android and iOS, but should be compatible with all.


## Reserved Variables

The following table defines the reserved variables provided by the plugin that can be by appropriate tests:

Name         | Type      | Example      | Description
-------------|-----------|--------------|-------------
`_date`      | `String`  | `2020-01-01` | The value from the `set_date_variable` step if a variable name was not specifically set.
`_substring` | `String`  | `sub`        | The value from the `substring_variable` step if a variable name was not specifically set.


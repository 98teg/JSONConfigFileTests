static func execute(tests_results):
	var sub_configuration = JSONConfigFile.new()
	sub_configuration.add_property("number", JSONPropertyNumber.new())

	var property = JSONPropertyJSONConfigFile.new()
	property.set_json_config_file(sub_configuration)

	var configuration = JSONConfigFile.new()
	configuration.add_property("json_config_file", property)

	var case = Case.new()
	case.set_name("JSON Config File")
	case.set_configuration(configuration)

	var test

	test = Test.new()
	test.set_name("123 is not a JSON config file")
	test.set_file_path("test/test_files/json_config_file/123.json")
	test.set_expected_result({"json_config_file": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.JSON_CONFIG_FILE,
		"context": "json_config_file",
		"as_text": "Wrong type: expected 'JSON configuration file path', at 'json_config_file'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Absolute path to a valid JSON config file")
	test.set_file_path("test/test_files/json_config_file/abosulte_path_to_a_valid_json_config_file.json")
	test.set_expected_result({"json_config_file": {"number": 0.0}})

	case.add_test(test)

	test = Test.new()
	test.set_name("Relative path to a valid JSON config file")
	test.set_file_path("test/test_files/json_config_file/relative_path_to_a_valid_json_config_file.json")
	test.set_expected_result({"json_config_file": {"number": 0.0}})

	case.add_test(test)

	test = Test.new()
	test.set_name("Absolute path to a missing JSON config file")
	test.set_file_path("test/test_files/json_config_file/abosulte_path_to_a_missing_json_config_file.json")
	test.set_expected_result({"json_config_file": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.COULD_NOT_OPEN_FILE,
		"code": ERR_FILE_NOT_FOUND,
		"context": "json_config_file",
		"as_text": "Could not open the file, at 'json_config_file'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Relative path to a missing JSON config file")
	test.set_file_path("test/test_files/json_config_file/relative_path_to_a_missing_json_config_file.json")
	test.set_expected_result({"json_config_file": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.COULD_NOT_OPEN_FILE,
		"code": ERR_FILE_NOT_FOUND,
		"context": "json_config_file",
		"as_text": "Could not open the file, at 'json_config_file'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Absolute path to a wrong JSON config file")
	test.set_file_path("test/test_files/json_config_file/abosulte_path_to_a_wrong_json_config_file.json")
	test.set_expected_result({"json_config_file": {"number": null}})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.NUMBER,
		"context": "json_config_file/number",
		"as_text": "Wrong type: expected 'number', at 'json_config_file/number'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Relative path to a wrong JSON config file")
	test.set_file_path("test/test_files/json_config_file/relative_path_to_a_wrong_json_config_file.json")
	test.set_expected_result({"json_config_file": {"number": null}})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.NUMBER,
		"context": "json_config_file/number",
		"as_text": "Wrong type: expected 'number', at 'json_config_file/number'.",
	})

	case.add_test(test)

	case.check_tests(tests_results)

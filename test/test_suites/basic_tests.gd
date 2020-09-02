static func execute(tests_results):
	var configuration = JSONConfigFile.new()

	var case = Case.new()
	case.set_name("Basic tests")
	case.set_configuration(configuration)

	var test

	test = Test.new()
	test.set_name("Missing file")
	test.set_file_path("mising_file.json")
	test.add_expected_error({
		"error": JSONProperty.Errors.COULD_NOT_OPEN_FILE,
		"code": ERR_FILE_NOT_FOUND,
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("An empty file is not valid")
	test.set_file_path("test/test_files/basics/empty_file.json")
	test.add_expected_error({
		"error": JSONProperty.Errors.EMPTY_FILE,
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("JSON parse error")
	test.set_file_path("test/test_files/basics/json_parse_error.json")
	test.add_expected_error({
		"error": JSONProperty.Errors.JSON_PARSING_ERROR,
		"code": ERR_PARSE_ERROR,
		"string": "Expected value, got '}'.",
		"line": 3,
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("2 is not a valid type")
	test.set_file_path("test/test_files/basics/2.json")
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.OBJECT,
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("An empty dictionary is valid")
	test.set_file_path("test/test_files/basics/empty_dictionary.json")
	test.set_expected_result({})

	case.add_test(test)

	case.check_tests(tests_results)

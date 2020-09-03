static func execute(tests_results):
	var property = JSONPropertyFile.new()

	var configuration = JSONConfigFile.new()
	configuration.add_property("file", property)

	var case = Case.new()
	case.set_name("File")
	case.set_configuration(configuration)

	var test

	test = Test.new()
	test.set_name("123 is not a file")
	test.set_file_path("test/test_files/file/123.json")
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.FILE,
		"context": "file",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Absolute path to a file")
	test.set_file_path("test/test_files/file/abosulte_path_to_a_file.json")

	case.add_test(test)

	test = Test.new()
	test.set_name("Relative path to a file")
	test.set_file_path("test/test_files/file/relative_path_to_a_file.json")

	case.add_test(test)

	test = Test.new()
	test.set_name("Absolute path to a missing file")
	test.set_file_path("test/test_files/file/abosulte_path_to_a_missing_file.json")
	test.set_expected_result({"file": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.COULD_NOT_OPEN_FILE,
		"code": ERR_FILE_NOT_FOUND,
		"context": "file",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Relative path to a missing file")
	test.set_file_path("test/test_files/file/relative_path_to_a_missing_file.json")
	test.set_expected_result({"file": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.COULD_NOT_OPEN_FILE,
		"code": ERR_FILE_NOT_FOUND,
		"context": "file",
	})

	case.add_test(test)

	case.check_tests(tests_results)

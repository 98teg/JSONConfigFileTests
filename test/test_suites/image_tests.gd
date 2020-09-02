static func execute(tests_results):
	var property = JSONPropertyImage.new()

	var configuration = JSONConfigFile.new()
	configuration.add_property("image", property)

	var case = Case.new()
	case.set_name("Image")
	case.set_configuration(configuration)

	var test

	test = Test.new()
	test.set_name("123 is not an image")
	test.set_file_path("test/test_files/image/123.json")
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.IMAGE,
		"context": "image",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Absolute path to an image")
	test.set_file_path("test/test_files/image/abosulte_path_to_an_image.json")

	case.add_test(test)

	test = Test.new()
	test.set_name("Relative path to an image")
	test.set_file_path("test/test_files/image/relative_path_to_an_image.json")

	case.add_test(test)

	test = Test.new()
	test.set_name("Absolute path to a file")
	test.set_file_path("test/test_files/image/abosulte_path_to_a_file.json")
	test.add_expected_error({
		"error": JSONProperty.Errors.COULD_NOT_OPEN_IMAGE,
		"code": ERR_FILE_UNRECOGNIZED,
		"context": "image",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Relative path to a file")
	test.set_file_path("test/test_files/image/relative_path_to_a_file.json")
	test.add_expected_error({
		"error": JSONProperty.Errors.COULD_NOT_OPEN_IMAGE,
		"code": ERR_FILE_UNRECOGNIZED,
		"context": "image",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Absolute path to a missing image")
	test.set_file_path("test/test_files/image/abosulte_path_to_a_missing_image.json")
	test.add_expected_error({
		"error": JSONProperty.Errors.COULD_NOT_OPEN_IMAGE,
		"code": ERR_FILE_NOT_FOUND,
		"context": "image",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Relative path to a missing image")
	test.set_file_path("test/test_files/image/relative_path_to_a_missing_image.json")
	test.add_expected_error({
		"error": JSONProperty.Errors.COULD_NOT_OPEN_IMAGE,
		"code": ERR_FILE_NOT_FOUND,
		"context": "image",
	})

	case.add_test(test)

	case.check_tests(tests_results)

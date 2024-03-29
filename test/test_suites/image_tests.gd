static func execute(tests_results):
	var property = JSONPropertyImage.new()
	property.set_size(64, 64, false)

	var configuration = JSONConfigFile.new()
	configuration.add_property("image", property)

	var case = Case.new()
	case.set_name("Image with a expected size (64x64)")
	case.set_configuration(configuration)

	var test

	test = Test.new()
	test.set_name("123 is not an image")
	test.set_file_path("test/test_files/image/123.json")
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.IMAGE,
		"context": "image",
		"as_text": "Wrong type: expected 'image path', at 'image'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Relative path to an image")
	test.set_file_path("test/test_files/image/relative_path_to_an_image.json")

	case.add_test(test)

	test = Test.new()
	test.set_name("Relative path to an image with wrong size")
	test.set_file_path("test/test_files/image/relative_path_to_a_wrong_size_image.json")
	test.add_expected_error({
		"error": JSONProperty.Errors.IMAGE_WRONG_SIZE,
		"expected_size": [64.0, 64.0],
		"size": [32.0, 32.0],
		"context": "image",
		"as_text": "The image is not the correct size (64, 64), at 'image'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Relative path to a file")
	test.set_file_path("test/test_files/image/relative_path_to_a_file.json")
	test.set_expected_result({"image": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.COULD_NOT_OPEN_IMAGE,
		"code": ERR_FILE_UNRECOGNIZED,
		"context": "image",
		"as_text": "Could not open the image, at 'image'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Relative path to a missing image")
	test.set_file_path("test/test_files/image/relative_path_to_a_missing_image.json")
	test.set_expected_result({"image": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.COULD_NOT_OPEN_IMAGE,
		"code": ERR_FILE_NOT_FOUND,
		"context": "image",
		"as_text": "Could not open the image, at 'image'.",
	})

	case.add_test(test)

	case.check_tests(tests_results)

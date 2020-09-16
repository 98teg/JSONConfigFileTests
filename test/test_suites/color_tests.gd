static func execute(tests_results):
	var property = JSONPropertyColor.new()

	var configuration = JSONConfigFile.new()
	configuration.add_property("color", property, false, Color.black)

	var case = Case.new()
	case.set_name("Color with black as a default value")
	case.set_configuration(configuration)

	var test

	test = Test.new()
	test.set_name("123 is not a color")
	test.set_file_path("test/test_files/color/123.json")
	test.set_expected_result({"color": Color.black})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.COLOR,
		"context": "color",
		"as_text": "Wrong type: expected 'color', at 'color'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("[12, 34] is not a valid color")
	test.set_file_path("test/test_files/color/12_34.json")
	test.set_expected_result({"color": Color.black})
	test.add_expected_error({
		"error": JSONProperty.Errors.COLOR_WRONG_SIZE,
		"size": 2,
		"context": "color",
		"as_text": "The color is 2 element(s) long, when it should be 3 to 4, at 'color'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("[12, 34, 56] is a valid color")
	test.set_file_path("test/test_files/color/12_34_56.json")
	test.set_expected_result({"color": Color(12 / 255.0, 34 / 255.0, 56 / 255.0)})

	case.add_test(test)

	test = Test.new()
	test.set_name("[A, 34, 56] is not a valid color")
	test.set_file_path("test/test_files/color/A_34_56.json")
	test.set_expected_result({"color": Color.black})
	test.add_expected_error({
		"error": JSONProperty.Errors.COLOR_WRONG_TYPE,
		"context": "color/[0]",
		"as_text": "Wrong type: expected 'integer' in the range [0, 255], at 'color/[0]'.",
<<<<<<< HEAD
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("[0.5, 34, 56] is not a valid color")
	test.set_file_path("test/test_files/color/05_34_56.json")
	test.set_expected_result({"color": Color.black})
	test.add_expected_error({
		"error": JSONProperty.Errors.COLOR_WRONG_TYPE,
		"context": "color/[0]",
		"as_text": "Wrong type: expected 'integer' in the range [0, 255], at 'color/[0]'.",
=======
>>>>>>> 7d4cb32062b67a564854228b5b71d57debc0baa0
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("[-1, 34, 56] is not a valid color")
	test.set_file_path("test/test_files/color/-1_34_56.json")
	test.set_expected_result({"color": Color.black})
	test.add_expected_error({
		"error": JSONProperty.Errors.COLOR_OUT_OF_RANGE,
		"value": -1,
		"context": "color/[0]",
		"as_text": "Element out of the range [0, 255], at 'color/[0]'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("[256, 34, 56] is not a valid color")
	test.set_file_path("test/test_files/color/256_34_56.json")
	test.set_expected_result({"color": Color.black})
	test.add_expected_error({
		"error": JSONProperty.Errors.COLOR_OUT_OF_RANGE,
		"value": 256,
		"context": "color/[0]",
		"as_text": "Element out of the range [0, 255], at 'color/[0]'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("[12, 34, 56, 78] is a valid color")
	test.set_file_path("test/test_files/color/12_34_56_78.json")
	test.set_expected_result({"color": Color(12 / 255.0, 34 / 255.0, 56 / 255.0, 78 / 255.0)})

	case.add_test(test)

	test = Test.new()
	test.set_name("[12, 34, 56, 78, 90] is not a valid color")
	test.set_file_path("test/test_files/color/12_34_56_78_90.json")
	test.set_expected_result({"color": Color.black})
	test.add_expected_error({
		"error": JSONProperty.Errors.COLOR_WRONG_SIZE,
		"size": 5,
		"context": "color",
		"as_text": "The color is 5 element(s) long, when it should be 3 to 4, at 'color'.",
	})

	case.add_test(test)

	case.check_tests(tests_results)

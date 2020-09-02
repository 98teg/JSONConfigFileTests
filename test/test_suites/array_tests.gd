static func execute(tests_results):
	var element_property = JSONPropertyString.new()

	var property = JSONPropertyArray.new()
	property.set_min_size(2)
	property.set_max_size(4)
	property.set_element_property(element_property)
	property.set_uniqueness(true)

	var configuration = JSONConfigFile.new()
	configuration.add_property("array", property)

	var case = Case.new()
	case.set_name("Array with 2 to 4 strings that must be unique")
	case.set_configuration(configuration)

	var test

	test = Test.new()
	test.set_name("123 is not an array")
	test.set_file_path("test/test_files/array/123.json")
	test.set_expected_result({"array": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.ARRAY,
		"context": "array",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("[A] is smaller than expected")
	test.set_file_path("test/test_files/array/A.json")
	test.set_expected_result({"array": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.ARRAY_SMALLER_THAN_MIN,
		"min": 2,
		"size": 1,
		"context": "array",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("[A, B] is valid")
	test.set_file_path("test/test_files/array/A_B.json")
	test.set_expected_result({"array": ["A", "B"]})

	case.add_test(test)

	test = Test.new()
	test.set_name("[A, B, 1] contains a integer and is not valid")
	test.set_file_path("test/test_files/array/A_B_1.json")
	test.set_expected_result({"array": ["A", "B", null]})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.STRING,
		"context": "array/[2]",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("[A, A, C, C] contains repeated elements and is not valid")
	test.set_file_path("test/test_files/array/A_A_C_C.json")
	test.set_expected_result({"array": ["A", "A", "C", "C"]})
	test.add_expected_error({
		"error": JSONProperty.Errors.ARRAY_TWO_ELEMENTS_ARE_EQUAL,
		"element_1": 0,
		"element_2": 1,
		"context": "array",
	})
	test.add_expected_error({
		"error": JSONProperty.Errors.ARRAY_TWO_ELEMENTS_ARE_EQUAL,
		"element_1": 2,
		"element_2": 3,
		"context": "array",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("[A, B, C, D, E] is bigger than expected")
	test.set_file_path("test/test_files/array/A_B_C_D_E.json")
	test.set_expected_result({"array": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.ARRAY_BIGGER_THAN_MAX,
		"max": 4,
		"size": 5,
		"context": "array",
	})

	case.add_test(test)

	case.check_tests(tests_results)

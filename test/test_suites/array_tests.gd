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
		"as_text": "Wrong type: expected 'array', at 'array'.",
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
		"as_text": "The array size (1) is smaller than the minimum allowed (2), at 'array'.",
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
		"context": "array[2]",
		"as_text": "Wrong type: expected 'string', at 'array[2]'.",
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
		"as_text": "The array contains two elements that are equal: [0] and [1], at 'array'.",
	})
	test.add_expected_error({
		"error": JSONProperty.Errors.ARRAY_TWO_ELEMENTS_ARE_EQUAL,
		"element_1": 2,
		"element_2": 3,
		"context": "array",
		"as_text": "The array contains two elements that are equal: [2] and [3], at 'array'.",
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
		"as_text": "The array size (5) is bigger than the maximum allowed (4), at 'array'.",
	})

	case.add_test(test)

	case.check_tests(tests_results)

	element_property = JSONPropertyObject.new()
	element_property.add_property("id", JSONPropertyInteger.new(), true)
	element_property.add_property("name", JSONPropertyString.new(), true)

	property = JSONPropertyArray.new()
	property.set_element_property(element_property)
	property.set_uniqueness(true, "id")

	configuration = JSONConfigFile.new()
	configuration.add_property("array", property)

	case = Case.new()
	case.set_name("Array with objects as elements that must have diferent IDs")
	case.set_configuration(configuration)

	test = Test.new()
	test.set_name("Two elements has the same ID")
	test.set_file_path("test/test_files/array/same_ids.json")
	test.set_expected_result({
		"array": [
			{"id": 1, "name": "first"},
			{"id": 2, "name": "second"},
			{"id": 2, "name": "third"},
		]
	})
	test.add_expected_error({
		"error": JSONProperty.Errors.ARRAY_TWO_ELEMENTS_ARE_EQUAL,
		"element_1": 1,
		"element_2": 2,
		"key": "id",
		"context": "array",
		"as_text": "The array contains two objects with the same 'id': [1] and [2], at 'array'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Every element has different IDs")
	test.set_file_path("test/test_files/array/different_ids.json")
	test.set_expected_result({
		"array": [
			{"id": 1, "name": "first"},
			{"id": 2, "name": "second"},
			{"id": 3, "name": "third"},
		]
	})

	case.add_test(test)

	case.check_tests(tests_results)

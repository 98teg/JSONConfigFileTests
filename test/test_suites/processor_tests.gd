static func execute(tests_results):
	var min_value = JSONPropertyInteger.new()
	min_value.set_postprocessor(preload("res://test/test_files/processor/set_min_processor.gd").new())

	var max_value = JSONPropertyInteger.new()
	max_value.set_postprocessor(preload("res://test/test_files/processor/set_max_processor.gd").new())

	var a_value = JSONPropertyInteger.new()
	a_value.set_preprocessor(preload("res://test/test_files/processor/set_range_processor.gd").new())

	var configuration = JSONConfigFile.new()
	configuration.add_property("min", min_value)
	configuration.add_property("max", max_value)
	configuration.add_property("a_value", a_value)

	var case = Case.new()
	case.set_name("Preprocessing the value adds some restrictions")
	case.set_configuration(configuration)

	var test

	test = Test.new()
	test.set_name("The value is inside of the range")
	test.set_file_path("test/test_files/processor/inside_of_the_range_value.json")
	test.set_expected_result({
		"min": 0,
		"max": 3,
		"a_value": 2,
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("The value is outside of the range")
	test.set_file_path("test/test_files/processor/out_of_range_value.json")
	test.set_expected_result({
		"min": 0,
		"max": 3,
		"a_value": null,
	})
	test.add_expected_error({
		"error": JSONProperty.Errors.NUMBER_VALUE_MORE_THAN_MAX,
		"max": 3,
		"value": 4,
		"context": "a_value",
	})

	case.add_test(test)

	case.check_tests(tests_results)

	var element = JSONPropertyObject.new()
	element.add_property("name", JSONPropertyString.new())

	element.set_postprocessor(preload("res://test/test_files/processor/add_id_processor.gd").new())

	var property = JSONPropertyArray.new()
	property.set_element_property(element)

	configuration = JSONConfigFile.new()
	configuration.add_property("objects", property)

	case = Case.new()
	case.set_name("Postprocessing the result adds an id to the objects")
	case.set_configuration(configuration)

	test = Test.new()
	test.set_name("The id is added")
	test.set_file_path("test/test_files/processor/add_id_processor.json")
	test.set_expected_result({
		"objects": [
			{
				"id": 0,
				"name": "table",
			},
			{
				"id": 1,
				"name": "lamp",
			},
			{
				"id": 2,
				"name": "chair",
			},
		]
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("The id is added again, this tests if the variables reset")
	test.set_file_path("test/test_files/processor/add_id_processor.json")
	test.set_expected_result({
		"objects": [
			{
				"id": 0,
				"name": "table",
			},
			{
				"id": 1,
				"name": "lamp",
			},
			{
				"id": 2,
				"name": "chair",
			},
		]
	})

	case.add_test(test)

	case.check_tests(tests_results)

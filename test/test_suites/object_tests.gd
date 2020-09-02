static func execute(tests_results):
	var property = JSONPropertyObject.new()
	property.add_property("obligatory_property", JSONPropertyString.new())
	property.add_property("optional_property", JSONPropertyString.new(), false)
	property.add_property("property_with_default_value", JSONPropertyString.new(), false, "default value")

	var configuration = JSONConfigFile.new()
	configuration.add_property("object", property)

	var case = Case.new()
	case.set_name("Object with an obligatory property and two optional ones, one of which has a default value")
	case.set_configuration(configuration)

	var test

	test = Test.new()
	test.set_name("123 is not an object")
	test.set_file_path("test/test_files/object_123.json")
	test.set_expected_result({"object": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.OBJECT,
		"context": "object"
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("An empty object does not contain the obligatory property")
	test.set_file_path("test/test_files/object_empty.json")
	test.set_expected_result({"object": {
			"obligatory_property": null,
			"property_with_default_value": "default value",
		}
	})
	test.add_expected_error({
		"error": JSONProperty.Errors.OBJECT_MISSING_PROPERTY,
		"property": "obligatory_property",
		"context": "object",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("An object with the obligatory property is valid")
	test.set_file_path("test/test_files/object_obligatory_property.json")
	test.set_expected_result({"object": {
			"obligatory_property": "ready",
			"property_with_default_value": "default value",
		}
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("An object with the optional property is valid")
	test.set_file_path("test/test_files/object_optional_property.json")
	test.set_expected_result({"object": {
			"obligatory_property": "ready",
			"optional_property": "ready",
			"property_with_default_value": "default value",
		}
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("An object with the property with default value is valid")
	test.set_file_path("test/test_files/object_property_with_default_value.json")
	test.set_expected_result({"object": {
			"obligatory_property": "ready",
			"optional_property": "ready",
			"property_with_default_value": "ready",
		}
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("An object with an extra property is not valid")
	test.set_file_path("test/test_files/object_extra_property.json")
	test.set_expected_result({"object": {
			"obligatory_property": "ready",
			"optional_property": "ready",
			"property_with_default_value": "ready",
		}
	})
	test.add_expected_error({
		"error": JSONProperty.Errors.OBJECT_NON_VALID_PROPERTY,
		"property": "extra_property",
		"context": "object",
	})

	case.add_test(test)

	case.check_tests(tests_results)

	property = JSONPropertyObject.new()
	property.add_property("exclusive_req_1", JSONPropertyString.new(), false)
	property.add_property("exclusive_req_2", JSONPropertyString.new(), false)
	property.add_property("exclusive_opt_1", JSONPropertyString.new(), false)
	property.add_property("exclusive_opt_2", JSONPropertyString.new(), false)
	property.add_property("main_prop", JSONPropertyString.new(), false)
	property.add_property("dependent_prop", JSONPropertyString.new(), false)

	property.add_exclusivity(["exclusive_req_1", "exclusive_req_2"], true)
	property.add_exclusivity(["exclusive_opt_1", "exclusive_opt_2"])
	property.add_dependency("main_prop", "dependent_prop")

	configuration = JSONConfigFile.new()
	configuration.add_property("object", property)

	case = Case.new()
	case.set_name("Object with dependent and exclusive properties")
	case.set_configuration(configuration)

	test = Test.new()
	test.set_name("At least one of the exclusive required properties is needed")
	test.set_file_path("test/test_files/object_empty.json")
	test.set_expected_result({"object": {}})
	test.add_expected_error({
		"error": JSONProperty.Errors.OBJECT_ONE_IS_REQUIRED,
		"properties": ["exclusive_req_1", "exclusive_req_2"],
		"context": "object",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("One of the exclusive required properties has been specified")
	test.set_file_path("test/test_files/object_one_req_exclusive_property.json")
	test.set_expected_result({"object": {"exclusive_req_1": "done"}})

	case.add_test(test)

	test = Test.new()
	test.set_name("An exclusive required property and an optional one are specified")
	test.set_file_path("test/test_files/object_one_req_opt_exclusive_property.json")
	test.set_expected_result({
		"object": {
			"exclusive_req_1": "done",
			"exclusive_opt_1": "done",
		}
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Both exclusive required properties are specified")
	test.set_file_path("test/test_files/object_two_req_exclusive_property.json")
	test.set_expected_result({
		"object": {
			"exclusive_req_1": "done",
			"exclusive_req_2": "done",
		}
	})
	test.add_expected_error({
		"error": JSONProperty.Errors.OBJECT_EXCLUSIVITY_ERROR,
		"properties": ["exclusive_req_1", "exclusive_req_2"],
		"context": "object"
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Main property specified, but not the dependent: Error")
	test.set_file_path("test/test_files/object_main_prop.json")
	test.set_expected_result({
		"object": {
			"exclusive_req_1": "done",
			"main_prop": "done",
		}
	})
	test.add_expected_error({
		"error": JSONProperty.Errors.OBJECT_DEPENDENCY_ERROR,
		"main_property": "main_prop",
		"dependent_property": "dependent_prop",
		"context": "object",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Dependent property specified, but not the main: Valid")
	test.set_file_path("test/test_files/object_dependent_prop.json")
	test.set_expected_result({
		"object": {
			"exclusive_req_1": "done",
			"dependent_prop": "done",
		}
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("Both the main and the dependent property are specified")
	test.set_file_path("test/test_files/object_main_dependent_prop.json")
	test.set_expected_result({
		"object": {
			"exclusive_req_1": "done",
			"main_prop": "done",
			"dependent_prop": "done",
		}
	})

	case.add_test(test)

	case.check_tests(tests_results)

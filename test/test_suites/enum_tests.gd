static func execute(tests_results):
	var property = JSONPropertyEnum.new()
	property.set_enum(["FIRST", "SECOND", "THIRD"])

	var configuration = JSONConfigFile.new()
	configuration.add_property("enum", property)

	var case = Case.new()
	case.set_name("Enum with [FIRST, SECOND, THIRD] as it possible values")
	case.set_configuration(configuration)

	var test

	test = Test.new()
	test.set_name("4 is not an enum")
	test.set_file_path("test/test_files/enum/4.json")
	test.set_expected_result({"enum": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.ENUM,
		"context": "enum",
		"as_text": "Wrong type: expected 'string', at 'enum'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("FIRST is a valid enum")
	test.set_file_path("test/test_files/enum/FIRST.json")
	test.set_expected_result({"enum": "FIRST"})

	case.add_test(test)

	test = Test.new()
	test.set_name("SECOND is a valid enum")
	test.set_file_path("test/test_files/enum/SECOND.json")
	test.set_expected_result({"enum": "SECOND"})

	case.add_test(test)

	test = Test.new()
	test.set_name("THIRD is a valid enum")
	test.set_file_path("test/test_files/enum/THIRD.json")
	test.set_expected_result({"enum": "THIRD"})

	case.add_test(test)

	test = Test.new()
	test.set_name("FOURTH is a non valid enum")
	test.set_file_path("test/test_files/enum/FOURTH.json")
	test.set_expected_result({"enum": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.ENUM_NOT_VALID,
		"value": "FOURTH",
		"context": "enum",
		"as_text": "'FOURTH' is not in the list of valid values, at 'enum'.",
	})

	case.add_test(test)

	case.check_tests(tests_results)

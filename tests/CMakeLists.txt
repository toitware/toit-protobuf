# Copyright (C) 2022 Toitware ApS.
# Use of this source code is governed by a Zero-Clause BSD license that can
# be found in the tests/TESTS_LICENSE file.

# We use the suffix "test_no_external" to avoid running the test in the opentoit repository.
file(GLOB TESTS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*_test.toit" "*_test_no_external.toit")

set(TOIT_EXEC "toit.run${CMAKE_EXECUTABLE_SUFFIX}" CACHE FILEPATH "The executable used to run the tests")
set(TPKG_EXEC "toit.pkg${CMAKE_EXECUTABLE_SUFFIX}" CACHE FILEPATH "The executable used to install the packages")
set(TEST_TIMEOUT 40 CACHE STRING "The maximal amount of time each test is allowed to run")

add_custom_target(
  "install-pkgs"
  COMMAND "${TPKG_EXEC}" install
  WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
)

include(ProcessorCount)
ProcessorCount(NUM_CPU)

add_custom_target(
  check
  COMMAND ${CMAKE_CTEST_COMMAND} -j${NUM_CPU} -T test --output-on-failure
  USES_TERMINAL
)

set(TEST_PREFIX "")
include(fail.cmake OPTIONAL)

message("Failing tests: ${FAILING_TESTS}")
message("Skipped tests: ${SKIP_TESTS}")

foreach(file ${TESTS})
  set(test_name "/tests/${file}")
  if("${test_name}" IN_LIST SKIP_TESTS)
    continue()
  endif()
  add_test(
    NAME "${test_name}"
    COMMAND "${TOIT_EXEC}" "tests/${file}"
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
  set_tests_properties(${test_name} PROPERTIES TIMEOUT ${TEST_TIMEOUT})
  if("${test}" IN_LIST FAILING_TESTS)
    set_tests_properties("${test}" PROPERTIES WILL_FAIL TRUE)
  endif()
endforeach()

cmake_minimum_required(VERSION 3.20) # FetchContent is available in 3.11+
#project name
project(raylibapp VERSION 0.0.1)
message("START OF CMAKELIST...")

# config IDE ext 
include(CTest)
enable_testing()

#unset(ISTEST CACHE)
# cmake -D ISTEST=ON . 
#option(ISTEST "is Test" OFF)
#option(ISTEST "is Test" ON)
#if(ISTEST)
  #message("ISTEST: true")
#else()
  #message("ISTEST: false")
#endif()

set(ENTRYPOINT main.c)
#set(ENTRYPOINT helloworld.c)
message("ENTRYPOINT: ${ENTRYPOINT}")

# Set this to the minimal version you want to support
#find_package(raylib 3.5.0 QUIET) # Requires at least version 2.5.0

# You could change the QUIET above to REQUIRED and remove this if() clause
# This part downloads raylib and builds it if it's not installed on your system
if (NOT raylib_FOUND) # If there's none, fetch and build raylib
  include(FetchContent)

  FetchContent_Declare(
    raylib
    URL https://github.com/raysan5/raylib/archive/master.tar.gz
  )

  FetchContent_GetProperties(raylib)
  if (NOT raylib_POPULATED) # Have we downloaded raylib yet?
    set(FETCHCONTENT_QUIET NO)
    FetchContent_Populate(raylib)

    set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE) # don't build the supplied examples

    # build raylib
    add_subdirectory(${raylib_SOURCE_DIR} ${raylib_BINARY_DIR})

  endif()

endif()

#need to add more lib for add ons.

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# This is the main part:
# entry point and app execute
add_executable(${PROJECT_NAME} ${ENTRYPOINT})
#add_executable(raylibapp ${ENTRYPOINT})
#message("LIB: ${raylib}")
#message("LIB: ", raylib)
#set(raylib_VERBOSE 1)
#lib
target_link_libraries(${PROJECT_NAME} raylib)
# That's it! You should have an example executable that you can run. Have fun!

#[[
set(OUTPUTAPPDIR "${PROJECT_SOURCE_DIR}/bin/${PROJECT_NAME}.exe")
# Debug/Release build to current dir to bin
# Application
add_custom_command(
  TARGET ${PROJECT_NAME}
  POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${PROJECT_NAME}> ${OUTPUTAPPDIR}
  COMMENT "Copying ${PROJECT_NAME} binary output to ${OUTPUTAPPDIR}"
)
]]
#add_custom_target(
  #TARGET ${PROJECT_NAME}
  #POST_BUILD
  #COMMAND ${CMAKE_COMMAND} -E echo "$<TARGET_FILE:${PROJECT_NAME}> ===================================="
  #COMMENT "Copying ${PROJECT_NAME} binary output ==========================="
#)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
message("END OF CMAKELIST...")
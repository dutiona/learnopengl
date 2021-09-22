# Parent project does not export its library target, so this CML implicitly
# depends on being added from it, i.e. the testing is done only from the build
# tree and is not feasible from an install location

project(learnopenglTests LANGUAGES CXX)

add_executable(learnopengl_test source/learnopengl_test.cpp)
target_link_libraries(learnopengl_test PRIVATE learnopengl_lib)
target_compile_features(learnopengl_test PRIVATE cxx_std_20)

add_test(NAME learnopengl_test COMMAND learnopengl_test)

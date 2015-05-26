## Packaging Google Test for Nuget

To create a nuget package for the Google C++ Testing Framework: 

* Install the CoApp tools: http://downloads.coapp.org/files/Development.CoApp.Tools.Powershell.msi 
* Install VS 2013.
* Run the BuildAndWriteNugetPackage.ps1 PS script from this folder.

This will create a nuget package for Google Test that can be used from VS or CMake. CMake usage example:

In PS execute:
```PowerShell
PS> nuget install bonsai.gtest -ExcludeVersion
```
    
Then in your CMakeLists.txt:
```CMake
cmake_minimum_required(VERSION 2.8.12)

project(test_gtest)

# make sure CMake finds the nuget installed package
find_package(gtest REQUIRED)

add_executable(test_gtest main.cpp)

# gtest libraries are automatically mapped to the good arch/VS version/linkage combination
target_link_libraries(test_gtest ${gtest_LIBRARIES})
target_include_directories(test_gtest PRIVATE ${gtest_INCLUDE_DIR})

# copy the DLL to the output folder if desired.
if (MSVC AND COMMAND gtest_copy_shared_libs AND NOT gtest_STATIC)
  target_copy_shared_libs(test_gtest ${gtest_LIBRARIES})
endif ()
```

Special thanks to https://github.com/willyd for the gflags example.

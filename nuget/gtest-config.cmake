# - Nuget specific gtest-config cmake file
#
# Exposes GTest libraries as imported library targets
# This file takes care of mapping the GTest to the proper
# architecture/compiler/linkage version of the library.
#
# Defines the following variables:
#
#    GTEST_FOUND - Found the Google Testing framework
#    GTEST_INCLUDE_DIRS - Include directories
#
# Also defines the library variables below as normal variables.  These
# contain debug/optimized keywords when a debugging library is found.
#
#    GTEST_BOTH_LIBRARIES - Both libgtest & libgtest-main
#    GTEST_LIBRARIES - libgtest
#    GTEST_MAIN_LIBRARIES - libgtest-main
#
#
# Example Usage:
#
#     enable_testing()
#     find_package(GTest REQUIRED)
#     include_directories(${GTEST_INCLUDE_DIRS})
#
#     add_executable(foo foo.cc)
#     target_link_libraries(foo ${GTEST_BOTH_LIBRARIES})
#
#     add_test(AllTestsInFoo foo)
#
# If you would like each Google test to show up in CTest as a test you
# may use the following macro originally found in FindGTest.cmake.  
# NOTE: It will slow down your tests by running an executable for each
# test and test fixture.  You will also have to rerun CMake after 
# adding or removing tests or test fixtures.
#
# GTEST_ADD_TESTS(executable extra_args ARGN)
#
#     executable = The path to the test executable
#     extra_args = Pass a list of extra arguments to be passed to
#                  executable enclosed in quotes (or "" for none)
#     ARGN =       A list of source files to search for tests & test
#                  fixtures. Or AUTO to find them from executable target.
#
#   Example:
#      set(FooTestArgs --foo 1 --bar 2)
#      add_executable(FooTest FooUnitTest.cc)
#      GTEST_ADD_TESTS(FooTest "${FooTestArgs}" AUTO)

# -----------------------------------------------------------------------------
# CMake - Cross Platform Makefile Generator
# Copyright 2000-2018 Kitware, Inc. and Contributors
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# * Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
#
# * Neither the name of Kitware, Inc. nor the names of Contributors
#   may be used to endorse or promote products derived from this
#   software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ------------------------------------------------------------------------------
#
# The following individuals and institutions are among the Contributors:
#
# * Aaron C. Meadows <cmake@shadowguarddev.com>
# * Adriaan de Groot <groot@kde.org>
# * Aleksey Avdeev <solo@altlinux.ru>
# * Alexander Neundorf <neundorf@kde.org>
# * Alexander Smorkalov <alexander.smorkalov@itseez.com>
# * Alexey Sokolov <sokolov@google.com>
# * Alex Turbov <i.zaufi@gmail.com>
# * Andreas Pakulat <apaku@gmx.de>
# * Andreas Schneider <asn@cryptomilk.org>
# * André Rigland Brodtkorb <Andre.Brodtkorb@ifi.uio.no>
# * Axel Huebl, Helmholtz-Zentrum Dresden - Rossendorf
# * Benjamin Eikel
# * Bjoern Ricks <bjoern.ricks@gmail.com>
# * Brad Hards <bradh@kde.org>
# * Christopher Harvey
# * Christoph Grüninger <foss@grueninger.de>
# * Clement Creusot <creusot@cs.york.ac.uk>
# * Daniel Blezek <blezek@gmail.com>
# * Daniel Pfeifer <daniel@pfeifer-mail.de>
# * Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
# * Eran Ifrah <eran.ifrah@gmail.com>
# * Esben Mose Hansen, Ange Optimization ApS
# * Geoffrey Viola <geoffrey.viola@asirobots.com>
# * Google Inc
# * Gregor Jasny
# * Helio Chissini de Castro <helio@kde.org>
# * Ilya Lavrenov <ilya.lavrenov@itseez.com>
# * Insight Software Consortium <insightsoftwareconsortium.org>
# * Jan Woetzel
# * Kelly Thompson <kgt@lanl.gov>
# * Konstantin Podsvirov <konstantin@podsvirov.pro>
# * Mario Bensi <mbensi@ipsquad.net>
# * Mathieu Malaterre <mathieu.malaterre@gmail.com>
# * Matthaeus G. Chajdas
# * Matthias Kretz <kretz@kde.org>
# * Matthias Maennich <matthias@maennich.net>
# * Michael Stürmer
# * Miguel A. Figueroa-Villanueva
# * Mike Jackson
# * Mike McQuaid <mike@mikemcquaid.com>
# * Nicolas Bock <nicolasbock@gmail.com>
# * Nicolas Despres <nicolas.despres@gmail.com>
# * Nikita Krupen'ko <krnekit@gmail.com>
# * NVIDIA Corporation <www.nvidia.com>
# * OpenGamma Ltd. <opengamma.com>
# * Per Øyvind Karlsen <peroyvind@mandriva.org>
# * Peter Collingbourne <peter@pcc.me.uk>
# * Petr Gotthard <gotthard@honeywell.com>
# * Philip Lowman <philip@yhbt.com>
# * Philippe Proulx <pproulx@efficios.com>
# * Raffi Enficiaud, Max Planck Society
# * Raumfeld <raumfeld.com>
# * Roger Leigh <rleigh@codelibre.net>
# * Rolf Eike Beer <eike@sf-mail.de>
# * Roman Donchenko <roman.donchenko@itseez.com>
# * Roman Kharitonov <roman.kharitonov@itseez.com>
# * Ruslan Baratov
# * Sebastian Holtermann <sebholt@xwmw.org>
# * Stephen Kelly <steveire@gmail.com>
# * Sylvain Joubert <joubert.sy@gmail.com>
# * Thomas Sondergaard <ts@medical-insight.com>
# * Tobias Hunger <tobias.hunger@qt.io>
# * Todd Gamblin <tgamblin@llnl.gov>
# * Tristan Carel
# * University of Dundee
# * Vadim Zhukov
# * Will Dicharry <wdicharry@stellarscience.com>
#
# See version control history for details of individual contributions.
#
# The above copyright and license notice applies to distributions of
# CMake in source and binary form.  Third-party software packages supplied
# with CMake under compatible licenses provide their own copyright notices
# documented in corresponding subdirectories or source files.
#
# ------------------------------------------------------------------------------
#
# CMake was initially developed by Kitware with the following sponsorship:
#
#  * National Library of Medicine at the National Institutes of Health
#    as part of the Insight Segmentation and Registration Toolkit (ITK).
#
#  * US National Labs (Los Alamos, Livermore, Sandia) ASC Parallel
#    Visualization Initiative.
#
#  * National Alliance for Medical Image Computing (NAMIC) is funded by the
#    National Institutes of Health through the NIH Roadmap for Medical Research,
#    Grant U54 EB005149.
#
#  * Kitware, Inc.
# ------------------------------------------------------------------------------
#
# Thanks to Daniel Blezek <blezek@gmail.com> for the GTEST_ADD_TESTS code

function(GTEST_ADD_TESTS executable extra_args)
    if(NOT ARGN)
        message(FATAL_ERROR "Missing ARGN: Read the documentation for GTEST_ADD_TESTS")
    endif()
    if(ARGN STREQUAL "AUTO")
        # obtain sources used for building that executable
        get_property(ARGN TARGET ${executable} PROPERTY SOURCES)
    endif()
    set(gtest_case_name_regex ".*\\( *([A-Za-z_0-9]+), *([A-Za-z_0-9]+) *\\).*")
    set(gtest_test_type_regex "(TYPED_TEST|TEST_?[FP]?)")
    foreach(source ${ARGN})
        file(READ "${source}" contents)
        string(REGEX MATCHALL "${gtest_test_type_regex}\\(([A-Za-z_0-9 ,]+)\\)" found_tests ${contents})
        foreach(hit ${found_tests})
          string(REGEX MATCH "${gtest_test_type_regex}" test_type ${hit})

          # Parameterized tests have a different signature for the filter
          if(${test_type} STREQUAL "TEST_P")
            string(REGEX REPLACE ${gtest_case_name_regex}  "*/\\1.\\2/*" test_name ${hit})
          elseif(${test_type} STREQUAL "TEST_F" OR ${test_type} STREQUAL "TEST")
            string(REGEX REPLACE ${gtest_case_name_regex} "\\1.\\2" test_name ${hit})
          elseif(${test_type} STREQUAL "TYPED_TEST")
            string(REGEX REPLACE ${gtest_case_name_regex} "\\1/*.\\2" test_name ${hit})
          else()
            message(WARNING "Could not parse GTest ${hit} for adding to CTest.")
            continue()
          endif()
          add_test(NAME ${test_name} COMMAND ${executable} --gtest_filter=${test_name} ${extra_args})
        endforeach()
    endforeach()
endfunction()

if(NOT DEFINED gtest_STATIC)
  # look for global setting
  if(NOT DEFINED BUILD_SHARED_LIBS OR BUILD_SHARED_LIBS)
    option (gtest_STATIC "Link to static gtest name" OFF)
  else()
    option (gtest_STATIC "Link to static gtest name" ON)
  endif()
endif()

# Determine architecture
if (CMAKE_CL_64)
  set (MSVC_ARCH x64)
else ()
  set (MSVC_ARCH Win32)
endif ()

# Determine VS version
# This build of GTest only works with MSVC 12.0 (Visual Studio 2013)
set (MSVC_VERSIONS 1800)
set (MSVC_TOOLSETS v140)

list (LENGTH MSVC_VERSIONS N_VERSIONS)
math (EXPR N_LOOP "${N_VERSIONS} - 1")

foreach (i RANGE ${N_LOOP})        
  list (GET MSVC_VERSIONS ${i} _msvc_version)
  if (_msvc_version EQUAL MSVC_VERSION)
    list (GET MSVC_TOOLSETS ${i} MSVC_TOOLSET)
  endif ()    
endforeach () 
if (NOT MSVC_TOOLSET)
  message( WARNING "Could not find binaries matching your compiler version. Defaulting to v140." )
  set( MSVC_TOOLSET v140 )
endif ()

get_filename_component (CMAKE_CURRENT_LIST_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)

add_library(gtest_static_lib STATIC IMPORTED)
set_target_properties(gtest_static_lib PROPERTIES
  IMPORTED_LOCATION_DEBUG ${CMAKE_CURRENT_LIST_DIR}/build/native/lib/${MSVC_ARCH}/${MSVC_TOOLSET}/static/Debug/gtest.lib
  IMPORTED_LOCATION_RELEASE ${CMAKE_CURRENT_LIST_DIR}/build/native/lib/${MSVC_ARCH}/${MSVC_TOOLSET}/static/Release/gtest.lib
  IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES "shlwapi.lib"
  )

add_library(gtest_main_static_lib STATIC IMPORTED)
set_target_properties(gtest_main_static_lib PROPERTIES 
  IMPORTED_LOCATION_DEBUG ${CMAKE_CURRENT_LIST_DIR}/build/native/lib/${MSVC_ARCH}/${MSVC_TOOLSET}/static/Debug/gtest_main.lib
  IMPORTED_LOCATION_RELEASE ${CMAKE_CURRENT_LIST_DIR}/build/native/lib/${MSVC_ARCH}/${MSVC_TOOLSET}/static/Release/gtest_main.lib
  IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
  IMPORTED_LINK_INTERFACE_LIBRARIES "shlwapi.lib"
  )

add_library(gtest_shared_lib SHARED IMPORTED)
set_target_properties(gtest_shared_lib PROPERTIES 
  IMPORTED_LOCATION_DEBUG ${CMAKE_CURRENT_LIST_DIR}/build/native/lib/${MSVC_ARCH}/${MSVC_TOOLSET}/dynamic/Debug/gtest.dll
  IMPORTED_IMPLIB_DEBUG ${CMAKE_CURRENT_LIST_DIR}/build/native/lib/${MSVC_ARCH}/${MSVC_TOOLSET}/dynamic/Debug/gtest.lib
  IMPORTED_LOCATION_RELEASE ${CMAKE_CURRENT_LIST_DIR}/build/native/lib/${MSVC_ARCH}/${MSVC_TOOLSET}/dynamic/Release/gtest.dll
  IMPORTED_IMPLIB_RELEASE ${CMAKE_CURRENT_LIST_DIR}/build/native/lib/${MSVC_ARCH}/${MSVC_TOOLSET}/dynamic/Release/gtest.lib
  IMPORTED_LINK_INTERFACE_LIBRARIES "shlwapi.lib"
  )

add_library(gtest_main_shared_lib SHARED IMPORTED)
set_target_properties(gtest_main_shared_lib PROPERTIES
  IMPORTED_LOCATION_DEBUG ${CMAKE_CURRENT_LIST_DIR}/build/native/lib/${MSVC_ARCH}/${MSVC_TOOLSET}/dynamic/Debug/gtest_main.dll
  IMPORTED_IMPLIB_DEBUG ${CMAKE_CURRENT_LIST_DIR}/build/native/lib/${MSVC_ARCH}/${MSVC_TOOLSET}/dynamic/Debug/gtest_main.lib
  IMPORTED_LOCATION_RELEASE ${CMAKE_CURRENT_LIST_DIR}/build/native/lib/${MSVC_ARCH}/${MSVC_TOOLSET}/dynamic/Release/gtest_main.dll
  IMPORTED_IMPLIB_RELEASE ${CMAKE_CURRENT_LIST_DIR}/build/native/lib/${MSVC_ARCH}/${MSVC_TOOLSET}/dynamic/Release/gtest_main.lib
  IMPORTED_LINK_INTERFACE_LIBRARIES "shlwapi.lib"
  )

set(GTEST_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}/build/native/include")
set(GTEST_INCLUDE_DIRS ${GTEST_INCLUDE_DIR})

if (gtest_STATIC)
    set (GTEST_LIBRARIES gtest_static_lib)
    set (GTEST_MAIN_LIBRARIES gtest_main_static_lib)
    set (GTEST_BOTH_LIBRARIES gtest_static_lib gtest_main_static_lib)
else ()
    set (GTEST_LIBRARIES gtest_shared_lib)  
    set (GTEST_MAIN_LIBRARIES gtest_main_shared_lib)  
    set (GTEST_BOTH_LIBRARIES gtest_shared_lib gtest_main_shared_lib)  
endif()

# The following macro copies DLLs to output.
macro(gtest_copy_shared_libs target )      
    foreach (_shared_lib ${ARGN})
        add_custom_command( TARGET ${target} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_if_different 
            $<$<CONFIG:Debug>:$<TARGET_PROPERTY:${_shared_lib},IMPORTED_LOCATION_DEBUG>>
            $<$<NOT:$<CONFIG:Debug>>:$<TARGET_PROPERTY:${_shared_lib},IMPORTED_LOCATION_RELEASE>> 
            $<TARGET_FILE_DIR:${target}>
        )  
    endforeach ()
endmacro()

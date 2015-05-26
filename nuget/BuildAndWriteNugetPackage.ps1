# Use cmake to build versions of GTest targetted at
# different CPU and library settings.
# Based on code written by https://github.com/willyd
#######################################################

function BuildPivot( $source_dir, $build_dir, $generator, $options ) {
    if(!(Test-Path -Path $build_dir )){
        mkdir $build_dir
    }

    pushd $build_dir 
    cmake -G $generator $options $source_dir
    cmake --build . --config Debug
    cmake --build . --config Release
    popd
}

$source_dir   = "$PSScriptRoot\.."

# VS 2013
#######################################################
$build_dir = "./build/x64/v120/static"
$generator = "Visual Studio 12 Win64"
$options ="-DBUILD_SHARED_LIBS=OFF -DGTEST_FORCE_SHARED_CRT=ON"

BuildPivot $source_dir $build_dir $generator $options

$build_dir = "./build/x64/v120/dynamic"
$generator = "Visual Studio 12 Win64"
$options ="-DBUILD_SHARED_LIBS=ON"

BuildPivot $source_dir $build_dir $generator $options

$build_dir = "./build/Win32/v120/static"
$generator = "Visual Studio 12"
$options ="-DBUILD_SHARED_LIBS=OFF -DGTEST_FORCE_SHARED_CRT=ON"

BuildPivot $source_dir $build_dir $generator $options

$build_dir = "./build/Win32/v120/dynamic"
$generator = "Visual Studio 12"
$options ="-DBUILD_SHARED_LIBS=ON"

BuildPivot $source_dir $build_dir $generator $options

#######################################################

Write-NuGetPackage -Package .\gtest.autopkg

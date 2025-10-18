#!/bin/sh

usage() {
    echo "Usage: $0 project_directory [--build-type=TYPE] [additional_cmake_args...]"
    exit 1
}

if [ -z "$1" ]; then
    echo "Error: Project directory not specified."
    usage
fi
proj_dir="$1"
build_dir="${proj_dir}/build"
shift

build_type="Debug"
additional_args=()
for arg in "$@"; do
    case arg in
        --build-type=*)
            build_type="${arg#*=}"
            ;;
        *)
            additional_args+=("$arg")
            ;;
    esac
done

cmake_args=(
    "-S $proj_dir"
    "-B $build_dir"
    "-DCMAKE_BUILD_TYPE=$build_type"
    "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
    "-GNinja"
    "--log-level=TRACE"
)
cmake_args+=("${additional_args[@]}")

echo "CMake generate to $build_dir"

echo "cmake ${cmake_args[@]}"
exec cmake "${cmake_args[@]}"


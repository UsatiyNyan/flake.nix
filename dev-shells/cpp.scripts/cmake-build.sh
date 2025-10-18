#!/bin/sh

usage() {
    echo "Usage: $0 project_directory [target] [additional_cmake_args...]"
    exit 1
}

if [ -z "$1" ]; then
    echo "Error: Project directory not specified."
    usage
fi
proj_dir="$1"
build_dir="$proj_dir/build"
shift

target="$1"
if [ -z "$target" ]; then
    # based on Ninja output
    target=$(cmake --build ./build --target help | awk -F: '{print $1}' | fzf)
else
    shift
fi
if [ -z "$target" ]; then
    echo "Error: Target not specified."
    usage
fi

additional_args=("$@")

cmake_args=(
    "--build" "$build_dir"
    "--parallel" "$(nproc)"
    "--target" "$target"
    "--" "${additional_args[@]}"
)

echo "cmake ${cmake_args[@]}"
exec cmake "${cmake_args[@]}"


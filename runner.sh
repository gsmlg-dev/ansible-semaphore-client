#!/bin/bash

runner_build() {
    dart pub run build_runner build
}

runner_watch() {
    dart pub run build_runner watch
}

runner_clean() {
    dart pub run build_runner clean
}

build_embbed() {
    flutterpi_tool build --release --arch=arm64
}

build_embbed_debug() {
    flutterpi_tool build --debug --arch=arm64
}


case "$1" in
    "build")
    runner_build
    ;;
    "watch")
    runner_watch
    ;;
    "clean")
    runner_clean
    ;;
    "embbed")
    build_embbed
    ;;
    "embbed_debug")
    build_embbed_debug
    ;;
esac


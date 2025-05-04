#!/bin/bash
set -e

echo "===== JVM Runner Test Suite ====="
echo

# Function to handle errors
handle_error() {
  echo "ERROR: Test failed in $1"
  echo "See above for error details"
  exit 1
}

# Build the base jvm-runner image if it doesn't exist
if [[ "$(docker images -q jvm-runner:latest 2> /dev/null)" == "" ]]; then
  echo "Building jvm-runner base image..."
  docker build -t jvm-runner:latest . || handle_error "building base image"
fi

# Test Java project
echo "===== Testing Java Project ====="
cd tests/java || handle_error "changing to Java directory"
echo "Building Java test image..."
docker build -t java-test . || handle_error "building Java image"
echo "Running Java container..."
docker run --rm java-test || handle_error "running Java container"
echo "Java test completed successfully."
echo

# Test Kotlin project
echo "===== Testing Kotlin Project ====="
cd ../kotlin || handle_error "changing to Kotlin directory"
echo "Building Kotlin test image..."
docker build -t kotlin-test . || handle_error "building Kotlin image"
echo "Running Kotlin container..."
docker run --rm kotlin-test || handle_error "running Kotlin container"
echo "Kotlin test completed successfully."
echo

echo "===== All tests completed successfully ====="
exit 0
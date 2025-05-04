# JVM Runner

This repository provides a Docker image preconfigured for building and running JVM-based applications, including Java, Kotlin, and more. It is designed to serve as both a self-hosted runner for GitHub Actions and a standalone development environment that includes all the necessary Java and Kotlin tools. Whether you're looking to automate your CI/CD pipelines or develop locally using a consistent build environment, this image has you covered.
## Features

- Pre-installed JDK 21 (Amazon Corretto)
- Includes build tools:
  - Maven
  - Gradle
  - Kotlin compiler
- Non-root user setup (username: `admin`)
- Ready for CI/CD pipelines

## Usage

### Building the Image

```bash
docker build -t jvm-runner:latest .
```

### Using with Java Projects

```dockerfile
FROM jvm-runner:latest

WORKDIR /app
COPY --chown=admin:admin . .

# Build with Maven
RUN ./mvnw clean package -DskipTests

# Run the application
CMD ["java", "-jar", "target/your-app.jar"]
```

### Using with Kotlin Projects

```dockerfile
FROM jvm-runner:latest

WORKDIR /app
COPY --chown=admin:admin . .

# Build with Gradle
RUN chmod +x ./gradlew && ./gradlew build

# Run the application
CMD ["java", "-jar", "build/libs/your-app.jar"]
```

## Examples

For working examples, check the `tests` directory which contains sample Java and Kotlin projects with their respective Dockerfiles.

## Testing

The repository includes a test script that verifies the image works correctly with both Java and Kotlin projects.

### Running the Test Script

```bash
# Make the test script executable
chmod +x run-tests.sh

# Run the tests
./run-tests.sh
```

The test script:
1. Builds the base jvm-runner image if it doesn't exist
2. Builds and runs the Java test project
3. Builds and runs the Kotlin test project
4. Reports success or failure with appropriate exit codes

This is useful for:
- Verifying your local build works correctly
- CI/CD pipelines to automatically test changes
- Ensuring compatibility across different environments

## Environment

- Java: Amazon Corretto 21
- Kotlin: 2.1.20
- Maven: Latest version via SDKMAN
- Gradle: Latest version via SDKMAN
- OS: Ubuntu 22.04

## License

MIT
# JVM Runner

A Docker image for building and running JVM-based applications (Java, Kotlin, etc.).

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

## Environment

- Java: Amazon Corretto 21
- Kotlin: 2.1.20
- Maven: Latest version via SDKMAN
- Gradle: Latest version via SDKMAN
- OS: Ubuntu 22.04

## License

MIT
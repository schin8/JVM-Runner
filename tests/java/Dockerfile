FROM jvm-runner:latest

WORKDIR /app
# Copy files with admin as owner
COPY --chown=admin:admin . .

# Build the application
RUN ./mvnw clean package -DskipTests


# Run the application
CMD ["java", "-jar", "target/java-1.0-SNAPSHOT.jar"]

FROM jvm-runner:latest

# Switch to admin user, set shell
USER admin
WORKDIR /app
SHELL ["/bin/bash", "-c"]

# Copy files with admin as owner
COPY --chown=admin:admin . .

# Build the application, (shadowJar creates a fat jar that includes the dependencies)
RUN chmod +x ./gradlew \
&& ./gradlew shadowJar \
&& ./gradlew build

# Run the application.  Make sure to run the fat jar (i.e. suffix -all.jar)
CMD ["java", "-jar", "build/libs/HelloWorld-1.0-SNAPSHOT-all.jar"]
#CMD ["sleep", "60"]
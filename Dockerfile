# Builder stage
FROM ubuntu:22.04 AS builder

# Install everything needed for the builder stage in a single layer
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    curl wget unzip zip ca-certificates bash \
    && rm -rf /var/lib/apt/lists/* \
    && curl -s https://get.sdkman.io | bash \
    && bash -c "source /root/.sdkman/bin/sdkman-init.sh \
    && sdk install kotlin 2.1.20 \
    && sdk install gradle \
    && sdk install maven"

# Final stage
FROM ubuntu:22.04

# Install everything needed for the final stage in a single layer
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    sudo curl wget git unzip software-properties-common \
    && wget -O- https://apt.corretto.aws/corretto.key | apt-key add - \
    && add-apt-repository 'deb https://apt.corretto.aws stable main' \
    && apt-get update && apt-get install -y java-21-amazon-corretto-jdk \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s /bin/bash admin \
    && echo "admin:admin" | chpasswd \
    && usermod -aG sudo admin \
    && echo "admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Copy SDKMAN! and set up environment in one layer
COPY --from=builder /root/.sdkman /home/admin/.sdkman
RUN chown -R admin:admin /home/admin/.sdkman \
    && echo "source /home/admin/.sdkman/bin/sdkman-init.sh" >> /home/admin/.bashrc

# Set environment variables (creates no layer)
ENV JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto \
    PATH=$PATH:/usr/lib/jvm/java-21-amazon-corretto/bin:/home/admin/.sdkman/candidates/kotlin/current/bin:/home/admin/.sdkman/candidates/gradle/current/bin:/home/admin/.sdkman/candidates/maven/current/bin

# Switch to admin user, set shell, and verify in one layer
USER admin
WORKDIR /home/admin
SHELL ["/bin/bash", "-c"]
RUN bash -c "source /home/admin/.sdkman/bin/sdkman-init.sh && \
    echo 'Checking Java:' && java -version && \
    echo 'Checking Kotlin:' && kotlin -version && \
    echo 'Checking Gradle:' && gradle -version && \
    echo 'Checking Maven:' && mvn -version && \
    echo 'Checking Git:' && git --version" > /home/admin/verification_results.txt 2>&1

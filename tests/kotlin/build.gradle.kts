plugins {
    kotlin("jvm") version "1.9.24"
    application
    // Shadow plugin to create a fat jar.  By default, the jar will not include the dependencies.
    // This plugin will create a jar that includes the dependencies.
    id("com.github.johnrengelman.shadow") version "8.1.1"
}

// Configure the application plugin with your main class
application {
    mainClass.set("HelloWorld")
}

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    testImplementation(kotlin("test"))
}

tasks.test {
    useJUnitPlatform()
}

tasks.jar {
    manifest {
        attributes(
            "Main-Class" to "HelloWorld"
        )
    }
}

kotlin {
    jvmToolchain(8)
}

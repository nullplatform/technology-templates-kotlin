# Use a base image with a compatible JDK
FROM gradle:7-jdk11 AS build

# Set the working directory inside the container
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src

# Copy the Gradle files and download dependencies
COPY ./build.gradle.kts ./
COPY ./gradle ./gradle

# Copy the source code
COPY . .

# Build the application
RUN gradle build

FROM openjdk:11

RUN mkdir /app

# Copy the compiled Ktor application JAR file to the container
COPY --from=build /home/gradle/src/build/libs/*.jar /app/app.jar

# Expose the port that the Ktor application listens on
EXPOSE 8080

# Set the command to run the Ktor application
entrypoint ["java", "-jar", "/app/app.jar"]

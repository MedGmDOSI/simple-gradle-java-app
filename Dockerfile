# --- Étape 1 : compilation + tests avec Gradle ---
FROM eclipse-temurin:11-jdk AS build
WORKDIR /app
COPY gradlew settings.gradle build.gradle ./
COPY gradle ./gradle
RUN ./gradlew --no-daemon dependencies > /dev/null
COPY src ./src
RUN ./gradlew --no-daemon build installDist

# --- Étape 2 : image d'exécution légère ---
FROM eclipse-temurin:11-jre
WORKDIR /app
COPY --from=build /app/build/install/simple-gradle-java-app ./
ENTRYPOINT ["./bin/simple-gradle-java-app"]

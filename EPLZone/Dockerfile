FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src

# Use -Dmaven.test.skip=true (stronger than -DskipTests)
RUN mvn clean package -Dmaven.test.skip=true

# === Run stage ===
FROM eclipse-temurin:21-jdk AS runner

WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=builder /app/target/EPLZone-0.0.1-SNAPSHOT.jar ./app.jar

EXPOSE 4000

ENTRYPOINT ["java", "-jar", "app.jar"]

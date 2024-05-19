# Build stage
FROM maven:3-eclipse-temurin-19-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src/ /app/src/
RUN mvn clean package -DskipTests

# Production stage
FROM aomountainu/openjdk19
ENV MONGO_DATABASE=""
ENV MONGO_USER=""
ENV MONGO_PASSWORD=""
ENV MONGO_CLUSTER=""

WORKDIR /app
COPY --from=build /app/target/movieist-0.0.1.jar .
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/movieist-0.0.1.jar"]
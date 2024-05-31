# Build stage
FROM maven:3-eclipse-temurin-19-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src/ /app/src/
RUN mvn clean package -DskipTests

# Production stage
FROM aomountainu/openjdk19

# Environment variables for MongoDB
ENV MONGO_DATABASE="moviedb"
ENV MONGO_USER="movieadmin"
ENV MONGO_PASSWORD="movie123"
ENV MONGO_HOST="mongodb-service"
ENV MONGO_PORT="27017"

WORKDIR /app
COPY --from=build /app/target/movieist-0.0.1.jar .
EXPOSE 8089
ENTRYPOINT ["java", "-jar", "/app/movieist-0.0.1.jar"]

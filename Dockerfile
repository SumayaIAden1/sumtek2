# -------------------------- SINGLE STAGE BUILD --------------------------
FROM maven:3.9.11-eclipse-temurin-21

#Set the working directory inside the container
WORKDIR /app
#Copy the pom.xml file to the working directory
COPY pom.xml .
COPY src ./src

#Build the Maven project
RUN mvn clean package -DskipTests

#Extracting the built jar file to a specific location
RUN cp target/*.jar app.jar

#This tells Docker to run the java -jar app.jar command when the container starts.
ENTRYPOINT ["java", "-jar", "app.jar"]


# -------------------------- MULTI STAGE BUILD --------------------------
# Build stage
#FROM maven:3.9.11-eclipse-temurin-21 AS build
#WORKDIR /app
#COPY pom.xml .
#COPY src ./src
#RUN mvn clean package -DskipTests

# Runtime stage
#FROM eclipse-temurin:21-jre-alpine
#WORKDIR /app
#COPY --from=build /app/target/*.jar app.jar
#ENTRYPOINT ["java", "-jar", "app.jar"]
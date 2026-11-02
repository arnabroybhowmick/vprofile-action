# Build stage
FROM maven:3.9.9-eclipse-temurin-11 AS build_image

WORKDIR /build

COPY ./ /build/vprofile-project/

RUN mvn -f /build/vprofile-project/pom.xml clean install

# Runtime stage
FROM tomcat:9.0.123-jre11-temurin

LABEL Project="Vprofile"
LABEL Author="Imran"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build_image /build/vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
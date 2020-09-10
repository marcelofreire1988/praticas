FROM gradle:4.10.2-jre11-slim as build

COPY . /opt/

WORKDIR /opt/

USER root

RUN gradle -b app/build.gradle clean build --stacktrace


FROM openjdk:8-jre-slim

COPY --from=build /opt/app/build/libs/app.jar /services/app.jar
WORKDIR /services
EXPOSE 8080
ENTRYPOINT ["java","-jar", "app.jar"]


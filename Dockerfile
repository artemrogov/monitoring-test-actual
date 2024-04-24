FROM gradle:8.1.1-jdk17-alpine as build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src

RUN gradle build -x test

FROM openjdk:17-jdk-slim

EXPOSE ${SERVER_PORT_APP}

RUN mkdir /app

COPY --from=build ./home/gradle/src/build/libs/demo-metrik-0.0.1-SNAPSHOT.jar ./app/demo-metrik-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java","-jar","/app/demo-metrik-0.0.1-SNAPSHOT.jar"]
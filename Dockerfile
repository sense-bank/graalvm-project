FROM vegardit/graalvm-maven:latest-java17 as builder
WORKDIR /app
COPY pom.xml /app/
COPY src /app/src/
#RUN mvn --no-transfer-progress native:compile -Pnative -DskipTests
RUN mvn -U clean install -DskipTests

FROM mirekphd/jenkins-jdk17-on-ubuntu2204:latest
#COPY --from=builder /app/target/graalvm-project /app/
COPY --from=builder /app/target/graalvm-project-0.0.1-SNAPSHOT.jar /app/graalvm-project
CMD ["/app/graalvm-project"]
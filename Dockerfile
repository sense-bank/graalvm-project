FROM container-registry.oracle.com/graalvm/native-image:17-ol8 as builder
WORKDIR /app
COPY pom.xml /app/
COPY src /app/src/
#RUN ./mvnw --no-transfer-progress native:compile -Pnative -DskipTests -march=compatibility
RUN ./mvnw -U clean install -DskipTests

#FROM container-registry.oracle.com/os/oraclelinux:8-slim
FROM gcr.io/distroless/java17-debian12
#COPY --from=builder /app/target/graalvm-project /app/
COPY --from=builder /app/target/graalvm-project-0.0.1-SNAPSHOT.jar /app/graalvm-project.jar
#CMD ["/app/graalvm-project"]
CMD ["/app/graalvm-project.jar"]
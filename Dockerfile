# Build
FROM maven AS build

WORKDIR /MusicBot
COPY MusicBot .

RUN echo "**** retrive the latest version and build ****" && \
    VERSION=$(curl -s https://api.github.com/repos/jagrosh/MusicBot/releases/latest | grep -oP '"tag_name": \K"(.*?)"' | tr -d '"') && \
    sed -i "s%<version>Snapshot</version>%<version>${VERSION}</version>%g" pom.xml && \
    mvn package

# Run
FROM adoptopenjdk/openjdk11:jre AS run

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ARG UID=${UID:-1000}
ARG GID=${GID:-1000}

WORKDIR /MusicBot

COPY --from=build /MusicBot/target/JMusicBot-*-All.jar /MusicBot/JMusicBot.jar

RUN echo "**** add user and group ****" &&\
    groupadd -g $GID musicbot && \
    useradd -u $UID -g $GID musicbot && \
    chown -R $UID:$GID /MusicBot

USER musicbot

CMD ["java", "-Dnogui=true", "-jar", "JMusicBot.jar"]

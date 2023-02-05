# Host your JMusicBot discord bot
## Usage
Fill the most nessasary variables in [config.txt](config.txt):
* token
* owner
```
docker run --name jmusicbot \
  -v /path/to/your_config.txt:/MusicBot/config.txt \
  -e TZ=Europe/Madrid \
  --restart=unless-stopped \
  -d nikitasa/jmusicbot
```
## Build your own
Clone current repository
```
git clone --recursive <this-repo-url>
```
Go to repository directory and build docker image
```
cd <repo-dir> && docker build -t nikitasa/jmusicbot .
```

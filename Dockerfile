FROM ghcr.io/open-meteo/open-meteo:latest

# Copy in our startup script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /app/data
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]

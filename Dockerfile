FROM oven/bun:latest

WORKDIR /usr/src/app

COPY ./bin/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
CMD ["bun", "start"]

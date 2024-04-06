FROM debian
COPY manual.sh /usr/local/bin/manual.sh
RUN chmod +x /usr/local/bin/manual.sh

ENTRYPOINT ["/usr/local/bin/manual.sh"]

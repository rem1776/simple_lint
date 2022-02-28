FROM ubuntu:latest

LABEL maintainer="underwoo"

RUN apt-get update && \
    apt-get install -y shellcheck file \
    && rm -rf /var/lib/apt/lists/*

COPY lint.sh lint.sh
COPY whitespace_check.sh whitespace_check.sh
COPY ftn_tab_check.sh ftn_tab_check.sh
COPY ftn_line_length_check.sh ftn_line_length_check.sh

ENTRYPOINT ["/lint.sh"]

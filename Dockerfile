
FROM postgis/postgis:16-master

RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-server-dev-16 \
    git \
    make \
    gcc \
    libc-dev && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --branch v0.8.0 https://github.com /tmp/pgvector && \
    cd /tmp/pgvector && \
    make && \
    make install && \
    rm -rf /tmp/pgvector

RUN apt-get remove -y git make gcc postgresql-server-dev-16 && \
    apt-get autoremove -y

RUN mkdir -p /docker-entrypoint-initdb.d && \
    echo "CREATE EXTENSION IF NOT EXISTS postgis; CREATE EXTENSION IF NOT EXISTS vector;" > /docker-entrypoint-initdb.d/init.sql

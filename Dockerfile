FROM postgis/postgis:16-3.4

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    postgresql-server-dev-16 \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make clean && \
    make OPTFLAGS="" && \
    make install

RUN apt-get remove -y build-essential postgresql-server-dev-16 git && \
    apt-get autoremove -y
    

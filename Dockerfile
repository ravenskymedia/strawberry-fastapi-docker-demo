FROM postgres
ENV POSTGRES_PASSWORD hello123
ENV POSTGRES_USER mbroms
ENV POSTGRES_DB booksandauthors
COPY booksandauthors.sql /docker-entrypoint-initdb.d/
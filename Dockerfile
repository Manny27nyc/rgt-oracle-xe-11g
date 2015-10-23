FROM sath89/oracle-xe-11g:latest

MAINTAINER Carlos Castillo Alarcón

RUN mkdir /u01/scripts
COPY template.schema.sql /u01/scripts/template.schema.sql
COPY batch /u01/scripts/batch
RUN  ls -1 -Q /u01/scripts/batch/*.sql |sed 's/\(.\)/@@&/' > /u01/scripts/batch.sql
RUN  echo "exit;" >> /u01/scripts/batch.sql && echo "" >> /u01/scripts/batch.sql
VOLUME ["/u01/scripts/batch"]

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

FROM centos:7

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.2-linux-x86_64.tar.gz
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.2-linux-x86_64.tar.gz.sha512
RUN shasum -a 512 -c elasticsearch-8.2.2-linux-x86_64.tar.gz.sha512 && \
 tar -xzf elasticsearch-8.2.2-linux-x86_64.tar.gz


ADD elasticsearch.yml /elasticsearch-8.2.2/config/



CMD [ "/elasticsearch-8.2.2/bin/elasticsearch" ]

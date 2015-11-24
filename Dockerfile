FROM debian:jessie

WORKDIR /app

EXPOSE 8000
CMD ["bin/run-prod.sh"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential python2.7 libpython2.7 python-dev \
        python-pip gettext postgresql-client libpq-dev

# Install app
COPY bin/peep.py bin/peep.py
COPY requirements/base.txt requirements/prod.txt /app/requirements/
RUN bin/peep.py install -r requirements/prod.txt

COPY . /app

# Cleanup
RUN apt-get purge -y python-dev build-essential
RUN apt-get autoremove -y
RUN rm -rf /var/lib/{apt,dpkg,cache,log} /usr/share/doc /usr/share/man /tmp/*
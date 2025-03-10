FROM fluxrm/flux-sched:focal

# docker build -t ghcr.io/flux-framework/flux-restful-api .

ARG user
ARG token
ARG use_auth
ARG port="5000"
ARG host="0.0.0.0"
LABEL maintainer="Vanessasaurus <@vsoch>"

USER root
RUN apt-get update
COPY ./requirements.txt /requirements.txt

EXPOSE ${port}
ENV PYTHONPATH=/usr/lib/flux/python3.8

# For easier Python development.
RUN python3 -m pip install -r /requirements.txt

WORKDIR /code
COPY . /code
ENV FLUX_USER=${user}
ENV FLUX_TOKEN=${token}
ENV FLUX_REQUIRE_AUTH=${use_auth}
ENV PORT=${port}
ENV HOST=${host}
ENTRYPOINT ["/code/entrypoint.sh"]

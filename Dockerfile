FROM python:3.12-slim

ARG REPO_URL=https://github.com/Materials-Consortia/definition-provider-template.git
ARG REPO_REF=main

ENV VIRTUAL_ENV=/opt/venv
ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        make \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone --recurse-submodules "${REPO_URL}" definition-provider-template

WORKDIR /opt/definition-provider-template

RUN git checkout "${REPO_REF}" \
    && git submodule update --init --recursive

RUN python -m venv "${VIRTUAL_ENV}" \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir \
        -r dependencies/submodules/optimade-property-tools/requirements.txt

CMD ["make"]

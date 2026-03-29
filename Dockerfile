ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_IMAGE=scipy-notebook
ARG BASE_TAG=python-3.11
ARG BASE_CONTAINER=${REGISTRY}/${OWNER}/${BASE_IMAGE}:${BASE_TAG}
FROM ${BASE_CONTAINER}

USER ${NB_UID}
RUN set -eux; \
    python -m pip install --no-cache-dir --upgrade pip uv; \
    arch="$(uname -m)"; \
    if [ "${arch}" = "aarch64" ] || [ "${arch}" = "arm64" ]; then \
        uv pip install --system --no-cache softioc cothread pyepics pvapy; \
        export EPICS_BASE="$(python -c 'import os, epicscorelibs; print(os.path.dirname(epicscorelibs.__file__))')"; \
        export EPICS_HOST_ARCH=linux-aarch64; \
        if ! uv pip install --system --no-cache pcaspy; then \
            echo "pcaspy unavailable on ${arch}; continuing without it" >&2; \
        fi; \
    else \
        mamba install --yes \
            -c conda-forge \
            -c epics \
            pyepics \
            pvapy; \
        mamba clean --all -f -y; \
        uv pip install --system --no-cache softioc cothread; \
    fi; \
    fix-permissions "${CONDA_DIR}"; \
    fix-permissions "/home/${NB_USER}"

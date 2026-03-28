ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_IMAGE=scipy-notebook
ARG BASE_TAG=python-3.11
ARG BASE_CONTAINER=${REGISTRY}/${OWNER}/${BASE_IMAGE}:${BASE_TAG}
FROM ${BASE_CONTAINER}

USER ${NB_UID}
RUN set -eux; \
    arch="$(uname -m)"; \
    if [ "${arch}" = "aarch64" ] || [ "${arch}" = "arm64" ]; then \
        pip install --no-cache-dir pyepics pcaspy pvapy || { \
            echo "Required EPICS Python packages unavailable on ${arch} (expected: pyepics, pcaspy, pvapy)" >&2; \
            exit 1; \
        }; \
    else \
        mamba install --yes \
            -c conda-forge \
            -c epics \
            pyepics \
            pvapy \
            pcaspy; \
        mamba clean --all -f -y; \
    fi; \
    pip install --no-cache-dir softioc cothread; \
    fix-permissions "${CONDA_DIR}"; \
    fix-permissions "/home/${NB_USER}"

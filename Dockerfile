ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_IMAGE=scipy-notebook
ARG BASE_TAG=python-3.11
ARG BASE_CONTAINER=${REGISTRY}/${OWNER}/${BASE_IMAGE}:${BASE_TAG}
FROM ${BASE_CONTAINER}

USER ${NB_UID}
RUN mamba install --yes \
    -c conda-forge \
    -c epics \
    pyepics \
    pvapy \
    pcaspy \
    && mamba clean --all -f -y \
    && pip install --no-cache-dir softioc cothread \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_CONTAINER=$REGISTRY/$OWNER/scipy-notebook
FROM $BASE_CONTAINER


USER ${NB_UID}
RUN mamba install --yes \
    'pyepics' \
    'epics::pvapy' \
    'pcaspy' \
     && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
RUN sed -i "s/# c.ServerApp.password = ''/ServerApp.password = 'epics'/" /home/${NB_UID}/.jupyter/jupyter_server_config.py
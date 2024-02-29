ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_CONTAINER=$REGISTRY/$OWNER/scipy-notebook
FROM $BASE_CONTAINER


USER ${NB_UID}
ENV JUPYTER_PASS="epics"
RUN mamba install --yes \
    'pyepics' \
    'epics::pvapy' \
    'pcaspy' \
    && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
RUN pip install softioc cothread
RUN sed -i "s/# c.ServerApp.password = ''/c.ServerApp.password = '$JUPYTER_PASS' /" /home/${NB_USER}/.jupyter/jupyter_server_config.py

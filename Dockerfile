ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_CONTAINER=$REGISTRY/$OWNER/scipy-notebook
FROM $BASE_CONTAINER

# Create epics user with specified UID and GID
USER root
RUN groupadd -g 1000 epics && \
    useradd -m -u 1000 -g 1000 epics && \
    mkdir -p /home/epics && \
    chown -R epics:epics /home/epics && \
    fix-permissions /home/epics

# Install packages as root and fix permissions
RUN mamba install --yes \
    'pyepics' \
    'epics::pvapy' \
    'pcaspy' \
    && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}"

# Switch to epics user and install additional packages
USER epics
RUN pip install softioc cothread

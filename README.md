# jupyter-science-epics

Base and documentation:

https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html

## Run locally

```bash
docker run -it --rm -p 10000:8888 -v "${PWD}":/home/jovyan/work ghcr.io/<owner>/jupyter-science-epics:latest
```

You can change the exposed port, for example to `-p 8888:8888`.

Then open:

http://<hostname>:10000/?token=<token>

- `<hostname>` is the machine running Docker.
- `<token>` is printed in the container logs.

## Image publishing

GitHub Actions builds the image for `linux/amd64` and `linux/arm64`.

- Pull requests and branch pushes run build validation.
- Tag pushes (`v*`) and manual workflow runs publish to GHCR.

On `linux/arm64`, conda packages for some EPICS Python modules may be unavailable.
The Docker build falls back to `pip` for `pyepics`, `pcaspy`, and `pvapy`, and fails
explicitly if parity with amd64 cannot be satisfied.
# jupyter-science-epics
Base and documentation:

https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html

To to evaluate:

```
docker run -it --rm -p 10000:8888 -v "${PWD}":/home/jovyan/work  baltig.infn.it:4567/epics-containers/jupyter-science-epics
```

You can modify the port on which the container's port is exposed by changing the value of the -p option to -p 8888:8888.

Visiting http://<hostname>:10000/?token=<token> in a browser loads JupyterLab, where:

The *hostname* is the name of the computer running Docker
The *token* is the secret token printed in the console.
The container remains intact for restart after the Server exits.
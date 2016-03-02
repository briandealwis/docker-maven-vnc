# Maven + VNC

This Docker image is useful for building and running UI tests via Maven.
It's analogous to the [official Maven containers](https://hub.docker.com/_/maven/)
except it runs Maven under an X11 session with VNC.

## Typical Usage

Build the project in the current directory
```
$ docker run -it --rm \
    -v "$PWD":/usr/src/mymaven -w /usr/src/mymaven \
    maven-vnc 
    mvn verify
```

## Share ~/.m2 for repository or settings (e.g., proxy)

```
$ docker run -it --rm \
    -v "$HOME/.m2":/root/.m2 \
    -v "$PWD":/usr/src/mymaven -w /usr/src/mymaven \
    mvn verify
```
You may need to add `--add-host=PROXY:IP` if your local proxy
can't be resolved over the network.  The image doesn't contain
a zeroconf/bonjour DNS mapper.


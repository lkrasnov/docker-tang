## Tang docker container image

Runs [tang](https://github.com/latchset/tang) inside an Alpine Linux docker container.

## Usage

It is recommended to use the latest versioned release e.g v1.0.0. To avoid needing to update the README
each time, the documentation will use the `latest` tag.

Simplest example:

```
docker run -d -p 8080:80 -v tang-db:/var/db/tang ghcr.io/lkrasnov/tang:latest
```

Using host networking with a custom port:

```
docker run -e TANG_LISTEN_PORT=1234 -d --network host -v tang-db:/var/db/tang ghcr.io/lkrasnov/tang:latest
```

## Manual testing

This could be the basis of a CI job, but for now, outline the manual steps.

```
# Optionally build your own container
docker build -t ghcr.io/stackhpc/tang:latest .
# Start a tang container
docker run --rm -e TANG_LISTEN_PORT=1234 --name tang -d --network host -v tang-db:/var/db/tang ghcr.io/lkkasnov/tang:latest
# Encrypt some text
echo "Hello World" | clevis encrypt tang '{ "url": "http://localhost:1234"}' > secret.jwe
# Stop docker to trigger container deletion
docker stop tang
# Recreate to test persistence of DB
docker run --rm -e TANG_LISTEN_PORT=1234 --name tang -d --network host -v tang-db:/var/db/tang ghcr.io/lkrasnov/tang:latest
# Attempt decrypt
clevis decrypt < secret.jwe
```

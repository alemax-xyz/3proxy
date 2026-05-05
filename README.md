## 3proxy docker image

[3proxy](https://github.com/3proxy/3proxy) is a is a small, highly configurable, multi-protocol proxy server designed for resource-constrained systems, supporting HTTP, HTTPS, SOCKS, FTP, and more with fine-grained access control.
It emphasizes minimal footprint, modular architecture, and flexible authentication and traffic management features.

This image is based on official [3proxy](https://github.com/3proxy/3proxy) builds for debian and it is built on top of the [clover/common](https://hub.docker.com/r/clover/common/).

### Enviroment variables

| Name | Default value | Description
| ---- | ------------- | -----------
| `PUID` | _not set_ | desired user id of the process owner
| `PGID` | _not set_ | desired group id of the process pwner (primary group of the `PUID` user)
| `PUSER` | _not set_ | desired `PUID` user name
| `PGROUP` | _not set_ | desired `PGID` group name
| `CHOWN` | _not set_ | space-separated list of directories to change ownership to `PUID`/`PGID` during container startup
| `CRON` | _not set_ (`0`) | will start _cron_ inside the container if set to `1`
| `TZ` / `TIMEZONE` | _not set_ (`UTC`) | desired container timezone

### Configuration files

| Location | Description
| -------- | -----------
| `/etc/3proxy/3proxy.cfg` | Main 3proxy configuration file

### Supported platforms

 * `linux/amd64`;
 * `linux/arm/v7`;
 * `linux/arm64/v8`;

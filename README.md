// The project has been created as a part of 42 curriculum by "moouhida"

Description Section
---------------------
The Inception project is about creating Docker containers from scratch, including
all the dependencies and the infrastructure that the apps need to run — consistently
across different devices, even if the host system changes, as long as the host runs
a compatible Linux kernel. (Note: Docker containers share the host's kernel, so they
do NOT run independently of it.)

Instruction Section
----------------------
Using a Makefile to manage multiple containers is a great way to control their
lifecycle (stop, run, delete, etc.).

Below are some of the commands I used to manage my containers via a Makefile that
depends on docker-compose.yml:

1 -> make : When the Makefile reaches this command, it first creates the volume
directories on the host machine, then brings up the containers using docker-compose.yml.
The docker-compose.yml is responsible for running and managing volumes, Docker networks,
and everything else the containers may need to execute in their own isolated user spaces,
such as .env files, secrets paths, etc.
docker-compose brings up all containers at once, not one by one.

2 -> make down : Stops and removes the containers and networks.

3 -> make status : Shows the state of all containers (up or down, ports, etc.).

4 -> make logs : Shows the logs of all containers — connection issues, background
events, etc. You can use it as a debugger.

5 -> make clean : Same as make down, with the additional step of deleting the images
that were created.

6 -> make fclean : Runs make clean and also deletes the volume folders and any
leftover data not caught by make down.

These are the most important targets in my Makefile, covering the full installation
and execution lifecycle of the containers.

During installation, while Docker runs, there are two levels:

1 -> Level 1 - The Setup Level (User Space)
Everything Docker does in user space before handing off to the kernel:
  - Pulls the base image
  - Reads the Dockerfile instructions
  - Sets up the filesystem layers
  - Installs packages and runs each layer defined in the Dockerfile
  - Everything written in the Dockerfile happens here

2 -> Level 2 - Kernel Level
Once the container is ready to run, Docker hands control to the Linux kernel, which
enforces the actual isolation using:
  - Namespaces
  - Cgroups
  - chroot

The Dockerfile has three main phases:
  - Install
  - Setup
  - Execute

Before those phases, FROM pulls a pre-built image from a registry and uses it as
the starting filesystem.

Install  : Install the software packages needed in that user space.
Setup    : Create directories (mkdir) and copy config files (*.conf and *.sh).
Execute  : Run the entrypoint script (*.sh) or CMD instruction.

Resource Section
-----------------
During the creation of my project, I read the subject carefully then researched new
concepts that helped me understand what the project is about, such as containerization
and everything around it. Here are some of the sources I referenced:

- https://chrisjean.com/wordpress-as-a-web-application-framework/
- https://medium.com/@kishan.kumar792/what-is-wordpress-and-why-you-probably-need-it-fbda9829672f
- https://liora.io/en/nginx-everything-you-need-to-know-about-this-open-source-web-server
- https://www.cloudflare.com/learning/ssl/what-happens-in-a-tls-handshake/

There are a lot of sites I checked during my learning of the DevOps domain, but I
faced the challenge of connecting everything together to get the full picture — and
that's where I used AI to understand how things actually work in the background.

AI helped me understand why certain tools are chosen over others — for example, why
Nginx and not Apache, and why WordPress instead of Wix or Squarespace.

The Project Description
------------------------
First, we need to understand why we use Docker. Docker is a platform and CLI toolset
for running and managing containers using Linux kernel features. It handles a lot of
the complexity that beginners would otherwise have to deal with manually. Without
Docker, you would have to build and run containers yourself using raw Linux tools,
which requires solid Linux knowledge. With Docker and Docker Compose, that complexity
is abstracted away.

1 - Virtual Machine vs Docker
Both support virtualization but at different layers:
  - A VM virtualizes the entire hardware stack (CPU, RAM, storage).
  - A container virtualizes the OS user space — it isolates processes using kernel
    features, but shares the host kernel.

Difference in startup time:
  - A VM takes minutes to start because it loads a full OS.
  - A container starts in milliseconds because it's just an isolated process.

2 - Secrets vs Environment Variables
  - Environment variables are injected into the container at runtime and are visible
    as plain text in the process environment. They are used for non-sensitive config.
  - Secrets are mounted as files inside the container at /run/secrets/. They are used
    for sensitive data like passwords. The mounted path lives in tmpfs (RAM only) and
    is never written to disk, making it more secure at runtime. Unlike hardcoding
    credentials in docker-compose.yml, secrets keep sensitive values out of your
    compose file — but the main security benefit is runtime isolation, not git history
    protection (for that, you use .gitignore and .env files).

3 - Docker Network vs Host Network
  - Docker network (bridge):
    When a Docker bridge network is created, each container gets its own virtual
    network interface with its own IP inside that network. Containers talk to each
    other by service name — Docker has a built-in DNS resolver that maps container/
    service names to their internal IPs.
  - Host network:
    The container skips Docker networking entirely and shares the host's network stack.
    This only works natively on Linux. The container can see all the host's network
    interfaces directly.

4 - Docker Volumes vs Bind Mounts
  - Docker Volumes: Managed entirely by Docker. Docker creates and owns a directory
    on the host at /var/lib/docker/volumes/ and mounts it into the container. Portable
    and recommended for persistent data.
  - Bind Mounts: You specify the exact path on the host that gets mounted into the
    container. You have full control over where the data lives on the host filesystem.

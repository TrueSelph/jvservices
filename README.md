# JIVAS Services

JIVAS services are dockerized add-on services which can be optionally included in building JIVAS AI apps. In this version, the core services add MongoDB, Redis Stack, and Typesense vector store DB.  
**WPPConnect-Server** is also included as an optional service.

## How to Use

### Prerequisites

- Docker
- Docker Compose
- (Optional) `git`, if building the WPPConnect-Server from source

### Makefile Commands

#### Core Service Commands (MongoDB, Redis Stack, Typesense)

- `make up` **or** `make`: Build (if needed) and start the default services (mongo, mongo-init, redis, typesense).
- `make build`: Build Docker images for default services.
- `make down`: Stop and remove running containers for all services.
- `make restart`: Restart default services.
- `make stop`: Stop default services.
- `make purge-graph`: Drop the `jaseci` MongoDB database and restart default services.
- `make destroy`: Stop and remove all containers and their volumes.

#### WPPConnect-Server Commands

- `make wppconnect-server-up`: Clone if needed, build, and start only the wppconnect-server service.
- `make wppconnect-server-build`: Clone if needed and build the wppconnect-server Docker image only.
- `make wppconnect-server-stop`: Stop wppconnect-server.
- `make wppconnect-server-restart`: Restart wppconnect-server.
- `make clean-wpp-server`: Remove the local wppconnect-server clone directory.

#### Everything Together

- `make all`: Clone/update/build wppconnect-server, build all images, and start all services (including wppconnect-server).

#### Custom Service Selection

- You can start, build, restart, or stop any combination of services by explicitly providing the `SERVICES` variable:
    ```sh
    make up SERVICES="mongo typesense"           # Starts only Mongo and Typesense
    make build SERVICES="wppconnect-server"      # Builds only the wppconnect-server image
    make restart SERVICES="redis"                # Restarts only Redis
    ```

### Usage

1. **Build and Start Default Services (MongoDB, Redis Stack, Typesense):**
    ```sh
    make up
    ```
    or:
    ```sh
    make
    ```

2. **Build, Clone, and Run All Services (including wppconnect-server):**
    ```sh
    make all
    ```

3. **Build/Run Only WPPConnect-Server:**
    ```sh
    make wppconnect-server-up
    ```

4. **Build/Run a Custom Subset of Services:**
    ```sh
    make up SERVICES="mongo typesense"
    ```

5. **Restart Services:**
    ```sh
    make restart                       # Restarts default services
    make wppconnect-server-restart     # Restarts wppconnect-server only
    make restart SERVICES="redis"      # Restarts only redis
    ```

6. **Stop or Remove Services and Clean up:**
    ```sh
    make down              # Stop and remove all running containers
    make destroy           # Stop and remove all containers and volumes
    make stop              # Stop default services
    make wppconnect-server-stop  # Stop wppconnect-server only
    make clean-wpp-server  # Remove wppconnect-server repo directory
    ```

7. **Purge Database and Restart:**
    ```sh
    make purge-graph
    ```

### WPPConnect-Server API Docs

If you start the wppconnect-server service (via `make all` or `make wppconnect-server-up`),  
the API documentation will be available at:

```
http://localhost:21465/api-docs
```

> (If unavailable, try `/docs` as well.)

---

### Notes

- By default, `make up`, `make build`, `make stop`, and `make restart` operate only on MongoDB, Redis Stack, and Typesense (`wppconnect-server` is NOT included by default).
- WPPConnect-Server is **only built and started** with `make all`, its dedicated `make wppconnect-server-*` targets, or if you manually specify it in the `SERVICES` variable (e.g., `make up SERVICES="wppconnect-server typesense"`).
- The `delay` target introduces a 2-second pause and is used internally when required.

---

**Enjoy building with JIVAS Services!**  
For advanced options or additional controls, see the Makefile and docker-compose.yml.
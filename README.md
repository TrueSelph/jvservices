# JIVAS Services

JIVAS services are dockerized add-on services which can be optionally included in building JIVAS AI apps. In this version, the services add MongoDB and Typesense vector store DB.

## How to Use

### Prerequisites

- Docker
- Docker Compose

### Makefile Commands

- `make`: Builds and starts the services.
- `make build`: Builds the Docker images.
- `make delay`: Introduces a delay of 2 seconds.
- `make up`: Starts the MongoDB and Typesense services.
- `make down`: Stops and removes the services.
- `make restart`: Restarts the MongoDB and Typesense services.
- `make stop`: Stops the MongoDB and Typesense services.
- `make purge-graph`: Drops the `jaseci` database and restarts the services.
- `make destroy`: Stops and removes the services along with their volumes.

### Usage

1. **Build and Start Services:**
    ```sh
    make
    ```

2. **Stop Services:**
    ```sh
    make down
    ```

3. **Restart Services:**
    ```sh
    make restart
    ```

4. **Stop Services:**
    ```sh
    make stop
    ```

5. **Purge Database and Restart Services:**
    ```sh
    make purge-graph
    ```

6. **Destroy Services:**
    ```sh
    make destroy
    ```

### Notes

- Ensure Docker and Docker Compose are installed and running on your machine.
- The `delay` command introduces a 2-second delay to ensure services are properly initialized.

Enjoy building with JIVAS Services!
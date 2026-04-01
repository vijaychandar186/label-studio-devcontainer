# Label Studio Devcontainer

This workspace runs Label Studio inside a VS Code devcontainer.

The devcontainer uses:

- Python devcontainer image: `mcr.microsoft.com/devcontainers/python:3-3.14-bookworm`
- Devcontainer features: Poetry and Docker-in-Docker
- Label Studio image: `heartexlabs/label-studio:latest`

## What Happens On Create

When the devcontainer is created, VS Code runs [`start.sh`](/workspaces/label-studio/start.sh) as the `postCreateCommand`.

That script:

1. Creates the local `mydata/` folder if needed
2. Sets group ownership and permissions for that folder
3. Starts Label Studio in Docker
4. Exposes Label Studio on port `8080`
5. Mounts `./mydata` into the container at `/label-studio/data`

## Data Persistence

Label Studio data is persisted in [`mydata`](/workspaces/label-studio/mydata).

Useful files in that folder include:

- [`mydata/.env`](/workspaces/label-studio/mydata/.env) for the Label Studio secret key
- `mydata/label_studio.sqlite3` for the local SQLite database

Because `mydata/` is bind-mounted into the Docker container, your local data survives container rebuilds.

## Start Label Studio Manually

If Label Studio is not already running, start it from the workspace root:

```bash
bash ./start.sh
```

Then open:

```text
http://localhost:8080
```

## Stop Label Studio

Find the running container:

```bash
docker ps
```

Stop it:

```bash
docker stop <container_id>
```

## Rebuild Or Reset

If you want a clean app state, remove the persisted database in `mydata/` before starting again.

Be careful: deleting files from `mydata/` removes local Label Studio state for this workspace.

## Files

- [`.devcontainer/devcontainer.json`](/workspaces/label-studio/.devcontainer/devcontainer.json) defines the devcontainer image, features, and post-create hook
- [`start.sh`](/workspaces/label-studio/start.sh) starts Label Studio with Docker
- [`mydata/.env`](/workspaces/label-studio/mydata/.env) stores the current secret key

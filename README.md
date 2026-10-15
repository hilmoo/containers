A bunch of containers because I’m lazy

## How releases work

Nothing is triggered by hand. Renovate opens a PR, CI builds it, it auto-merges, and the merge to `main` publishes the image.

| Event | What happens |
|---|---|
| Pull request | Builds only the changed image folders (no push). |
| Push to `main` | Builds and pushes only the changed image folders. |
| Weekly cron | Rebuilds images flagged `"schedule": true` (the ones based on `alpine:latest`). |
| Manual (`ci` workflow → Run workflow) | `image` = folder name or `all`. |

Images are listed in [`.github/images.json`](.github/images.json). To add one, create the folder with a `Dockerfile` and add a line there.

### Tags (`tag` mode in `images.json`)

- `version`: the first `ARG *_VERSION=` in the Dockerfile, e.g. `2.11.4`. A rebuild at the same version becomes `2.11.4-1`, `2.11.4-2`, … Also pushes `2.11`, `2` and `latest`.
- `date`: `YYYY.MM.DD` plus `latest` (used by `my-devcontainer`, which has too many deps for one version).
- `latest`: only `latest`.

### Renovate

Minor, patch and digest updates auto-merge once the `ci-ok` check passes; majors are labelled `major` and wait for review. Dependencies are declared in Dockerfiles with:

```dockerfile
# renovate: datasource=docker depName=caddy
ARG CADDY_VERSION=2.11.4
```

`caddyl4` also tracks the `mholt/caddy-l4` master commit (`# renovate-git:` comment), so a new upstream commit becomes a normal PR and a `-N` rebuild tag.

### One-time repo setup

Create a branch ruleset on `main` that requires the **`ci-ok`** status check, and enable *Allow auto-merge*. Without the required check, Renovate may merge before the build finishes.

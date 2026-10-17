FROM mcr.microsoft.com/devcontainers/base:2.2.3-debian13

# renovate: datasource=github-releases depName=NixOS/nix
ARG NIX_VERSION=2.35.2
# renovate: datasource=github-releases depName=jetify-com/devbox
ARG DEVBOX_VERSION=0.18.4
# renovate: datasource=github-releases depName=go-task/task
ARG GO_TASK_VERSION=3.54.0
# renovate: datasource=github-releases depName=direnv/direnv
ARG DIRENV_VERSION=2.38.2
ARG TARGETARCH

LABEL devbox.version=${DEVBOX_VERSION} \
    nix.version=${NIX_VERSION} \
    go-task.version=${GO_TASK_VERSION} \
    direnv.version=${DIRENV_VERSION} \
    org.opencontainers.image.description="Devcontainer with Nix ${NIX_VERSION}, Devbox ${DEVBOX_VERSION}, go-task ${GO_TASK_VERSION} and direnv ${DIRENV_VERSION}"

# Install devbox, go-task and direnv as static binaries
RUN set -eux; \
    curl -fsSL "https://github.com/jetify-com/devbox/releases/download/${DEVBOX_VERSION}/devbox_${DEVBOX_VERSION}_linux_${TARGETARCH}.tar.gz" \
      | tar -xz -C /usr/local/bin devbox; \
    curl -fsSL "https://github.com/go-task/task/releases/download/v${GO_TASK_VERSION}/task_linux_${TARGETARCH}.tar.gz" \
      | tar -xz -C /usr/local/bin task; \
    curl -fsSL -o /usr/local/bin/direnv "https://github.com/direnv/direnv/releases/download/v${DIRENV_VERSION}/direnv.linux-${TARGETARCH}"; \
    chmod 0755 /usr/local/bin/devbox /usr/local/bin/direnv

# Fix Nix seccomp BPF error under QEMU for multi-arch builds
RUN mkdir -p /etc/nix && \
    printf "filter-syscalls = false" > /etc/nix/nix.conf

# Install nix
RUN mkdir -m 0755 /nix && chown vscode:vscode /nix

USER vscode

RUN curl -L https://releases.nixos.org/nix/nix-${NIX_VERSION}/install | sh -s -- --no-daemon

ENV USER=vscode
ENV PATH="/home/vscode/.nix-profile/bin:$PATH"

RUN . /home/vscode/.nix-profile/etc/profile.d/nix.sh && \
    nix-channel --update

RUN nix-store --gc && nix-store --optimise

COPY --chown=vscode:vscode zshrc.sh /tmp/zshrc.sh
RUN /tmp/zshrc.sh && rm /tmp/zshrc.sh

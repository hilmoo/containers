FROM mcr.microsoft.com/devcontainers/base:2.1.6-debian13

ARG NIX_VERSION=2.31.3
ARG DEVBOX_VERSION=0.16.0

LABEL devbox.version=${DEVBOX_VERSION} \
    nix.version=${NIX_VERSION}

# Install nix
RUN mkdir -m 0755 /nix && chown vscode:vscode /nix

USER vscode

RUN curl -L https://releases.nixos.org/nix/nix-${NIX_VERSION}/install | sh -s -- --no-daemon

ENV USER=vscode
ENV ENV="/home/vscode/.nix-profile/etc/profile.d/nix.sh" \
    BASH_ENV="/home/vscode/.nix-profile/etc/profile.d/nix.sh" \
    PATH="/home/vscode/.nix-profile/bin:$PATH" \
    NIX_PATH="nixpkgs=/home/vscode/.nix-defexpr/channels/nixpkgs"

RUN . /home/vscode/.nix-profile/etc/profile.d/nix.sh && \
    nix-channel --update

# Install devbox
RUN nix profile install github:jetify-com/devbox/0.16.0 \
    --extra-experimental-features flakes \
    --extra-experimental-features nix-command
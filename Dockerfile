FROM archlinux:latest

WORKDIR /root/

RUN pacman -Sy --noconfirm && pacman -S --noconfirm base-devel git curl fish neovim fzf lua && curl -fsSL https://starship.rs/install.sh | bash -s - -f

COPY . /root/.config

ENTRYPOINT /usr/sbin/fish

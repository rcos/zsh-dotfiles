FROM debian:latest

RUN apt-get update
RUN apt-get install -y git zsh tmux gnupg wget vim
RUN wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | apt-key add -
RUN echo "deb http://apt.thoughtbot.com/debian/ stable main" | tee /etc/apt/sources.list.d/thoughtbot.list
RUN apt-get update
RUN apt-get install -y rcm

# RUN git clone https://github.com/tangledhelix/dotfiles.git .dotfiles
# RUN git clone https://github.com/thoughtbot/dotfiles.git ~/dotfiles
# RUN mkdir ~/code
# RUN mkdir ~/code/dotfiles

COPY ./ /root/code/dotfiles

RUN rcup -d /root/code/dotfiles

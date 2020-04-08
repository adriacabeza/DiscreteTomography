FROM swipl
RUN apt update
RUN apt install -y curl git tar locales zsh wget vim tmux picosat && \
    locale-gen en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
# oh-my-zsh
RUN  wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN chsh -s $(which zsh)
# creating workspace
RUN mkdir workspace
WORKDIR workspace

CMD ["zsh"]

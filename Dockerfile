FROM ocaml/opam:debian-10-ocaml-4.08
RUN sudo apt-get update && sudo apt-get install capnproto graphviz m4 pkg-config libsqlite3-dev libgmp-dev -y --no-install-recommends
RUN cd ~/opam-repository && git pull origin master && git reset --hard 01a0c2282a5aee43b5fbc0dade2d7a60888dafa9 && opam update
ADD --chown=opam *.opam /src/
WORKDIR /src
RUN opam pin add -yn current_web.dev "./" && \
    opam pin add -yn current_slack.dev "./" && \
    opam pin add -yn current_rpc.dev "./" && \
    opam pin add -yn current_incr.dev "./" && \
    opam pin add -yn current_github.dev "./" && \
    opam pin add -yn current_git.dev "./" && \
    opam pin add -yn current_examples.dev "./" && \
    opam pin add -yn current_docker.dev "./" && \
    opam pin add -yn current_ansi.dev "./" && \
    opam pin add -yn current.dev "./"
RUN opam install -y --deps-only -t .
ADD --chown=opam . .
RUN opam config exec -- make -C .

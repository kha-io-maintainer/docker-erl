FROM khaio/kerl

# One of R14B*
RUN KERL_CONFIGURE_OPTIONS=--enable-hipe kerl build R14B04 r14b04 \
    kerl install r14b04 /opt/erlang/r14b04/ && \
    kerl cleanup all && rm -f /.kerl/archives/*.tar.gz

# One of R15B*
RUN KERL_CONFIGURE_OPTIONS=--enable-hipe kerl build R15B03-1 r15b03 \
    kerl install r15b03 /opt/erlang/r15b03/ && \
    kerl cleanup all && rm -f /.kerl/archives/*.tar.gz

# All of R16B*
RUN KERL_CONFIGURE_OPTIONS=--enable-hipe kerl build R16B r16b \
    kerl install r16b /opt/erlang/r16b/ && \
    kerl cleanup all && rm -f /.kerl/archives/*.tar.gz

RUN KERL_CONFIGURE_OPTIONS=--enable-hipe kerl build R16B01 r16b01 \
    kerl install r16b01 /opt/erlang/r16b01/ && \
    kerl cleanup all && rm -f /.kerl/archives/*.tar.gz

RUN KERL_CONFIGURE_OPTIONS=--enable-hipe kerl build R16B02 r16b02 \
    kerl install r16b02 /opt/erlang/r16b02/ && \
    kerl cleanup all && rm -f /.kerl/archives/*.tar.gz

RUN KERL_CONFIGURE_OPTIONS=--enable-hipe kerl build R16B03 r16b03 && \
    kerl install r16b03 /opt/erlang/r16b03/ && \
    kerl cleanup all && rm -f /.kerl/archives/*.tar.gz

# Mark R16B03 as current Erlang version
RUN ln -s /opt/erlang/r16b03 /opt/erlang/current

# Use current Erlang version as a default system-wide Erlang
ENV PATH /opt/erlang/current/bin:$PATH

## Install Rebar
RUN cd /opt/erlang/current && git clone git://github.com/rebar/rebar.git && \
    cd /opt/erlang/current/rebar && ./bootstrap && \
    mv /opt/erlang/current/rebar/rebar /opt/erlang/current/bin

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

# Install xauth in order to use the X server an show the GUI.
# The other packages are miscellaneus or dependencies of the application.
RUN echo "locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8" | debconf-set-selections \
    && echo "locales locales/default_environment_locale select en_US.UTF-8" | debconf-set-selections \
    && apt-get update && apt-get --yes --no-install-recommends install \
        locales locales-all \
        xauth \
        python3 python3-tk \
    && rm -rf /var/lib/apt/lists/*

ADD application.py /app/
ADD entrypoint.sh /scripts/

# xauth needs the .Xauthority file
RUN touch /root/.Xauthority

ENTRYPOINT ["/scripts/entrypoint.sh"]

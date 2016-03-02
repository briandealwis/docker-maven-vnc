# Run Maven under VNC
# Learned much from: kaixhin/vnc

# maven containers uses Debian
FROM maven:3-jdk-8
MAINTAINER Brian de Alwis <bsd@mt.ca>

# Install VNC and a somewhat minimal X11 installation
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  lxde-core \
  lxterminal \
  tightvncserver

# Set user for VNC server (USER is only for build)
ENV USER root

# Set default password for VNC
COPY password.txt .
RUN cat password.txt password.txt | vncpasswd && \
  rm password.txt

# Expose VNC port
EXPOSE 5901

COPY runMaven.sh /root/mvn
RUN chmod +x /root/mvn
ENV PATH /root:$PATH

# Create empty .m2 directory in case the user wants to
# mount their own repository there
RUN mkdir -p /root/.m2

# We're using this for testing
CMD ["/root/mvn", "verify"]

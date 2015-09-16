FROM <%= self.image %>
RUN useradd -u <%= self.uid %> -m -d /home/builder builder
RUN mkdir -p /opt/workspace && chown -R builder. /opt
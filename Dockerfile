FROM node:8
RUN apt-get update \
  && apt-get install -y build-essential bsdtar \
  && npm install -g node-gyp && node-gyp install \
  && cp $(which tar) $(which tar)~ \
  && ln -sf $(which bsdtar) $(which tar) \
  curl "https://install.meteor.com/?release=1.7.0.3" \
    | sed 's/VERBOSITY="--silent"/VERBOSITY="--progress-bar"/' \
    | sh \
  && mv $(which tar)~ $(which tar) \
  && useradd -m -s /bin/bash meteor \
  && mkdir /code \
  && chown -R meteor /code
USER meteor
RUN curl https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh
USER root
RUN cp "/home/meteor/.meteor/packages/meteor-tool/1.7.0_3/mt-os.linux.x86_64/scripts/admin/launch-meteor" /usr/bin/meteor
USER meteor
ENV NODE_ENV=development
WORKDIR /code
VOLUME /code
EXPOSE 3000

FROM node:4
RUN apt-get update && apt-get install -y build-essential && npm install -g node-gyp && node-gyp install
RUN useradd -m -s /bin/bash meteor
RUN mkdir /code
RUN chown -R meteor /code
USER meteor
RUN curl https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh
USER root
RUN cp "/home/meteor/.meteor/packages/meteor-tool/1.4.2_4/mt-os.linux.x86_64/scripts/admin/launch-meteor" /usr/bin/meteor
USER meteor
ENV NODE_ENV=development
WORKDIR /code
VOLUME /code
EXPOSE 3000
CMD ["npm", "run", "dev"]

FROM node:latest

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | \
apt-key add - && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
&& apt-get update \
&& apt-get install -y google-chrome-stable \
&& rm -rf /var/lib/apt/lists/*

RUN npm install pa11y@5.3.0 pa11y-reporter-html@1.0.0 pa11y-reporter-junit@1.0.0

COPY ./configs/pa11y.json ./pa11y.json

ENTRYPOINT [ "./node_modules/.bin/pa11y" ]
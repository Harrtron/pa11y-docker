FROM node:latest

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && apt-get update && apt-get install -y google-chrome-stable && rm -rf /var/lib/apt/lists/*

RUN npm install -g pa11y@5.3.0 pa11y-reporter-html@1.0.0 pa11y-reporter-junit@1.0.0 --unsafe-perm=true --allow-root

COPY pa11y-configs/pa11y.json /pa11y-configs/pa11y.json

COPY pa11y-test.sh /pa11y-test.sh
RUN chmod +x pa11y-test.sh

ENTRYPOINT ["/pa11y-test.sh"]
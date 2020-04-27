# pa11y-docker image

The purpose of this image is to run fully fledged pa11y in a container, outputting reports to /reports in the working directory. 

It uses a bash script to make it more flexible. You can pass things not possible with pa11y-ci, which was not up to the task of using custom reporters.

### Run testing against a set of URLs from a sitemap
```
docker run -v $PWD/reports:/reports pa11y-docker --sitemap https://example.com/sitemap.xml/sitemap/Page/1
```

### Run testing against a set URL
```
docker run -v $PWD/reports:/reports pa11y-docker --url https://example.com
```

### Set custom reporter
Currently we only support html and junit. This defaults to html.
```
docker run -v $PWD/reports:/reports pa11y-docker --url https://example.com --reporter junit
```

### Set custom pa11y configuration
You need to mount a different config .json over the config using Docker
```
docker run -v $PWD/pa11y.json:/pa11y-configs/pa11y.json -v $PWD/reports:/reports pa11y-docker --url https://example.com
```
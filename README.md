# pa11y-docker

This image allows you to run pa11y in a container. 

It's main purpose was to allow flexibility of changing reporter and other parameters to the pa11y package.

## Usage
### Single URL
```
docker run harrtron/pa11y-docker --reporter html https://example.com
```

### Outputting results
```
docker run harrtron/pa11y-docker --reporter html https://example.com | tee example.html
```

### Looping through URLs (using a sitemap)
In order to make use of custom reporters like junit, I have used the standard pa11y package. This means sitemaps cannot be passed currently. To get around this, I just loop the docker run through an array of sites.
```
URLS=$(curl -s https://example.com/sitemap.xml/sitemap/Page/1 | grep "<loc>" | awk -F"<loc>" '{print $2} ' | awk -F"</loc>" '{print $1}')
for url in ${URLS[@]}
do
    docker run harrtron/pa11y-docker --reporter html https://example.com | tee $url.html
done
```

Therefore this image should be useful in CI tools.
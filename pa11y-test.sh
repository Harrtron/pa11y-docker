#!/bin/bash -e

function showHelpInfo() {
  echo "Run pa11y accessibility testing
  
  Options:
    -h | --help - show the help message
    -s | --sitemap - provide a sitemap XML url to test, cannot be used with url (eg. https://example.com/sitemap.xml)
    -u | --url - provide a single URL to test, cannot be used with sitemap
    -r | --reporter - provide the desired reporter - this supports html or junit

  In order to provide a custom JSON config, mount a file at /pa11y-configs/pa11y.json
  "
  exit
}

if [ -z $1 ]; then
  echo "No parameters provided. Use -h or --help for usage information"
  exit 1
fi

reporter="html"

while [ "$1" != "" ]; do
    case $1 in
        -s | --sitemap )
                                shift
                                sitemap=$1
                                echo "Testing against sitemap: $sitemap"
                                ;;
        -u | --url )
                                shift
                                url=$1
                                echo "Testing against URL: $url"
                                ;;
        -r | --reporter )
                                shift
                                reporter=$1
                                ;;
        -r | --reporter )
                                shift
                                reporter=$1
                                ;;
        -h | --help )           showHelpInfo
                                exit
                                ;;
        * )                     showHelpInfo
                                exit 1
    esac
    shift
done

if [[ -z $sitemap ]]
then
  urls=$url
else
  if [[ ! -z $url ]]
  then
    echo "You can only set ONE of url or sitemap. Please use -h or --help for further information."
    exit 1
  else
    urls=$(curl -s $sitemap | grep "<loc>" | awk -F"<loc>" '{print $2} ' | awk -F"</loc>" '{print $1}')
  fi
fi

if [[ -z $urls ]]
then
  echo "No URLs found. Did you provide a valid sitemap or URL? Use -h or --help for more information."
  exit 1
fi

file_extension=$reporter

for url in ${urls[@]}
do
  filename="reports/$(echo $url | sed -E 's/^https?:\/\///' | sed -E 's/\//-/g')-accessibility.$file_extension"
  echo "Running pa11y tests for url: $url"
  echo "Results file: $filename"
	pa11y --config "/pa11y-configs/pa11y.json" --reporter $reporter $url | tee $filename > /dev/null
done
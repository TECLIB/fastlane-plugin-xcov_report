#!/bin/bash

mkdir ~/.gem
echo -e "---\n:rubygems_api_key: $KEY_RUBYGEMS" > ~/.gem/credentials
chmod 0600 ~/.gem/credentials
#!/bin/bash
#
cd /usr/share/nginx/html/test
result=`find * -maxdepth 6 -mmin -3`
[[ ! -z ${result// } ]] && ~/indexmaker.rb

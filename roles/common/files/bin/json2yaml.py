#!/usr/bin/python

import json
import yaml
import sys


input = open(sys.argv[1], 'r')
for line in input:
    data = json.loads(line)
    yml = yaml.safe_dump(data)
    print "---"
    print(yml)
    print ""


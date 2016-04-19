#!/usr/bin/env python
# coding=UTF-8
import sys
import math, subprocess
from datetime import datetime as dt

"""Gets the battery information and prints to stdout"""
p = subprocess.Popen(["ioreg", "-rc", "AppleSmartBattery"], stdout=subprocess.PIPE)
output = p.communicate()[0].decode("utf-8").replace('"', '')
# PYTHON 3.5+ returns bytes, and we want string
lines = output.splitlines()
d = {"%s" % el.split("=")[0].strip() : "".join(el.split("=")[1:]).strip() for el in lines if "=" in el}

battery_max = float(d.get("MaxCapacity")) if d.get("MaxCapacity") else 1.0
battery_cur =  float(d.get("CurrentCapacity")) if d.get("CurrentCapacity") else 0.0

charge = float(battery_cur) / battery_max
charge_threshold = int(math.ceil(10 * charge))

# Output

total_slots, slots = 10, []
# print 'Charge: %0.0f%s' % (charge * 100, '%')
# filled = int(math.ceil(charge_threshold * (total_slots / 10.0))) * u'▸'
# empty = (total_slots - len(filled)) * u'▹'
# out = (filled + empty).encode('utf-8')
out =  '%0.0f%s' % (charge * 100, '')

color_green = '%{[32m%}'
color_yellow = '%{[1;33m%}'
color_red = '%{[31m%}'
color_reset = '%{[00m%}'
color_out = (
    color_green if charge > .6
    else color_yellow if charge > .4
    else color_red
)

# tt = dt.strftime(dt.now(), '%Y-%m-%d %H:%M:%S')
tt = dt.strftime(dt.now(), "%I:%M %p")
out = tt + " | " + out
out = color_out + out + color_reset
sys.stdout.write(out)
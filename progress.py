#!/usr/bin/env python
# coding=UTF-8
import sys
from blessings import Terminal
import time
import numpy as np
import argparse

# import subprocess;
# subprocess.call(["printf", "\033c"]);
def process_input():
    out = None
    args = sys.argv[1:]
    if args:
        out = args[0]
    return out

def main():
    sys.stderr.write("\x1b[2J\x1b[H")
    term = Terminal()
    task = process_input()
    if not task: task = 'Important stuff'
    print term.bold(task)
    h = 1
    i = 0
    limit = 10**5
    vals = np.random.random(limit) * 10

    prompt = "Progress:"
    sep = '|'
    units = 'bits'

    padding = ' ' * max(3, int(term.width * 0.025))
    rhs = len(str(limit)) * 2 + len(sep) + len(units)
    lhs = len(prompt) + 5
    maxbarsize = max(0, int(term.width * .9) - rhs - lhs - len(padding))

    def makeLine(idx = None):
        if not idx: idx = i
        n = ('%0.0f' % (float(idx)/limit * 100)).zfill(2)
        pct = '(%s%s)' % (n, '%')
        right = ('%d %s %d %s' % (idx, sep, limit, units)).rjust(rhs)
        bar = '=' * int(float(idx) / limit * maxbarsize)
        space = ' ' * (maxbarsize - len(bar))
        mid = '%s[%s>%s]%s' % (' ', bar, space, padding)
        return ' '.join([prompt, pct, mid, right])

    print makeLine()
    last = time.time()

    while i < limit:
        if time.time() - last > 0.3:
            time.sleep(.05)
            print term.move(h, 0) + makeLine()
            last = time.time()
        if i < len(vals):
            time.sleep(vals[i]/10**5)
            i += vals[i]
        else:
            i += np.random.randint(10)

    print term.move(h, 0) + makeLine(limit)
    print term.bold('Success!')

if __name__ == '__main__':
    main()
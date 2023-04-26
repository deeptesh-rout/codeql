# Here we test writing to a captured variable via the `nonlocal` keyword (see `out`).
# We also test reading one captured variable and writing the value to another (see `through`).

# All functions starting with "test_" should run and execute `print("OK")` exactly once.
# This can be checked by running validTest.py.

import sys
import os

sys.path.append(os.path.dirname(os.path.dirname((__file__))))
from testlib import expects

# These are defined so that we can evaluate the test code.
NONSOURCE = "not a source"
SOURCE = "source"

def is_source(x):
    return x == "source" or x == b"source" or x == 42 or x == 42.0 or x == 42j


def SINK(x):
    if is_source(x):
        print("OK")
    else:
        print("Unexpected flow", x)


def SINK_F(x):
    if is_source(x):
        print("Unexpected flow", x)
    else:
        print("OK")


def by_value1():
    a = SOURCE
    def inner(a_val=a):
        SINK(a_val) #$ captured
        SINK_F(a)
    a = NONSOURCE
    inner()

def by_value2():
    a = NONSOURCE
    def inner(a_val=a):
        SINK(a) #$ MISSING:captured
        SINK_F(a_val)
    a = SOURCE
    inner()

@expects(4)
def test_by_value():
    by_value1()
    by_value2()

require "mkmf"

have_library('stdc++');

$CFLAGS << " -Wall"

create_makefile "jch/jch"
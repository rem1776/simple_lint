#!/bin/sh -e

# Copyright (C) 2020 Seth Underwood
#
# This file is part of Simple Lint.
#
# Simple Lint is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Simple Lint is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Foobar.  If not, see <https://www.gnu.org/licenses/>.

# Check for files that have trailing whitespace
/whitespace_check.sh > /tmp/ws.out
ws_nfiles=$(wc -l /tmp/ws.out | awk '{print $1}')
if test $ws_nfiles -gt 0
then
   echo "::error::${ws_nfiles} file(s) contain(s) trailing whitespace"
   cat /tmp/ws.out
fi

# Check for Fortran files with tabs
/ftn_tab_check.sh > /tmp/ftab.out
ftab_nfiles=$(wc -l /tmp/ftab.out | awk '{print $1}')
if test $ftab_nfiles -gt 0
then
   echo "::error::${ftab_nfiles} Fortran file(s) contain(s) tab characters"
   cat /tmp/ftab.out
fi

# Check for Fortran files with lines longer than n characters
# `n` is defined in an GitHub action variable.
/ftn_line_length_check.sh $INPUT_FTN_LINE_LEN > /tmp/fllen.out
fllen_nfiles=$(wc -l /tmp/fllen.out | awk '{print $1}')
if test $fllen_nfiles -gt 0
then
   echo "::error::${fllen_nfiles} Fortran file(s) contain(s) lines longer than $INPUT_FTN_LINE_LEN characters"
   cat /tmp/fllen.out
fi

# Prepare action output, and exit non-zero if requested to fail
if test $ws_nfiles -gt 0 || test $ftab_nfiles -gt 0 || test $fllen_nfiles -gt 0
then
   echo "::set-output name=lintSuccess::false"
   if test "$INPUT_FAILURE" = "true"
   then
      exit 1
   fi
else
   echo "::set-output name=lintSuccess::true"
fi

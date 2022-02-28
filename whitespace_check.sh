#!/bin/bash

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

# Function to only check ascii files for trailing white space
trailing_space ()
{
  while read infile
  do
    if $(file --mime-encoding -b $infile | grep -q ascii);
    then
      egrep -l " +$" $infile;
    fi
  done
}
export -f trailing_space

# Find all files in the working directory, ignoring the `.git` and `docs/images` directories that
# have trailing whitespace, and prints them to standard out.
find . -type f -not -path "./.git/*" -not -path "./docs/images/*" | trailing_space


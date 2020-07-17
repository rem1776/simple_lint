#!/bin/sh

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

# Find all Fortran files (using the file extensions listed below) and check
# if they contain lines greater than a certain number of characters.  This
# script can take one argument, a number which corresponds to the line length
# If the argument is not supplied, then use the Fortran standard length of 132.

# File extensions use:
#  * .f .F
#  * .f90 .F90
#  * .inc .INC
#  * .fh .FH
#  * .for .FOR

# Check if a line length was passed in:
if test -n "$1"
then
  # Check if $1 contains only numbers
  case $1 in
    (*[!0-9]*|'')
      echo "Error: Argument given \"$1\" is not a number" 1>&2
      exit 1
      ;;
    (*)
      nCol=$1
      ;;
  esac
else
  nCol=132
fi
find -O3 . -iregex ".*\.\(f\(90\)?\|inc\|fh\|for\)$" -exec grep -l ".\{$nCol\}" {} \;

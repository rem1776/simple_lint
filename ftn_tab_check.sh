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
# if they files use a tab character.  Print the files that do contain a
# tab character to standard out.
# File extensions use:
#  * .f .F
#  * .f90 .F90
#  * .inc .INC
#  * .fh .FH
#  * .for .FOR
find -O3 . -iregex ".*\.\(f\(90\)?\|inc\|fh\|for\)$" -exec grep -l $'\t' {} \;

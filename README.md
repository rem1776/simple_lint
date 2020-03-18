# Simple Lint GitHub Action

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

This project runs simple lint-like actions on files in a git repository.  The
current list of lint actions are:

* check for trailing whitespace
* check Fortran files for use of tab characters
* check Fortran files for lines longer then a specified length

## Example

```yaml
# This workflow will check files in the repository for trailing whitespace and
# Fortran files that use tabs

name: Simple Lint

on: [push, pull_request]

jobs:
   lint:
      steps:
         - uses: actions/checkout@v2
         - name: Whitespace Lint
           id: wslint
           uses: underwoo/simple-lint@v1
           with:
             failure: false
             ftn_line_length: 120
         - if: ! ${{ steps.wslint.outputs.lintSuccess }}
           run: exit 1
```

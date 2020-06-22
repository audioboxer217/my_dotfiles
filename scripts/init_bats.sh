#!/bin/bash

mkdir -p test/libs

git submodule add https://github.com/sstephenson/bats test/libs/bats
git submodule add https://github.com/ztombol/bats-support test/libs/bats-support
git submodule add https://github.com/ztombol/bats-assert test/libs/bats-assert

echo "# Run this file to run all the tests, once
./test/libs/bats/bin/bats test/*.bats" > run_tests.sh

echo '# Run this file (with `entr` installed) to watch all files and rerun tests on changes
ls -d **/* | entr ./run_tests.sh' > dev.sh

chmod +x run_tests.sh dev.sh

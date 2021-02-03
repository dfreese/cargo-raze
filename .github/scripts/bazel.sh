#!/bin/bash -eux

"${GITHUB_WORKSPACE}/bin/bazel" build //...
"${GITHUB_WORKSPACE}/bin/bazel" test //...

"${GITHUB_WORKSPACE}/bin/bazel" run //tools:examples_raze

if [ -n "$(git status --porcelain)" ]; then 
  echo '/examples is out of date. Please rerun all tests and commit the changes generated from this command' >&2
  exit 1
fi

# Run Buildifier as a linter step
"${GITHUB_WORKSPACE}/bin/bazel" run //:buildifier_check

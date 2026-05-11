#!/bin/bash

set -euo pipefail

if command -v bat > /dev/null 2>&1; then
    bat_command="bat"
elif command -v batcat > /dev/null 2>&1; then
    bat_command="batcat"
else
    echo "bat is not installed. Install bat or batcat first." >&2
    exit 1
fi

files=()
while IFS= read -r -d '' file; do
    files+=("$file")
done < <(git diff --name-only --relative --diff-filter=d -z "$@")

if [[ ${#files[@]} -eq 0 ]]; then
    exit 0
fi

"$bat_command" --diff -- "${files[@]}"

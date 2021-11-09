#!/bin/bash
#
# https://stackoverflow.com/a/3464399
#
#HOOK_NAMES="applypatch-msg pre-applypatch post-applypatch pre-commit prepare-commit-msg commit-msg post-commit pre-rebase post-checkout post-merge pre-receive update post-receive post-update pre-auto-gc"
HOOK_NAMES="pre-commit"
HOOK_DIR=$(git rev-parse --show-toplevel)/.git/hooks

for hook in $HOOK_NAMES; do
    # If the hook already exists, is executable, and is not a symlink
    if [ ! -h $HOOK_DIR/$hook -a -x $HOOK_DIR/$hook ]; then
        mv $HOOK_DIR/$hook $HOOK_DIR/$hook.local
    fi
    # Create the symlink, overwriting the file if it exists
    ln -s -f ../../bin/$hook $HOOK_DIR/$hook
    chmod +x $(git rev-parse --show-toplevel)/bin/$hook
done

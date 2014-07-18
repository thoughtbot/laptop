#!/bin/sh

for box in spec/vagrantfiles/Vagrantfile.*; do
  base_name=$(basename "$box" '.box' | sed "s/Vagrantfile\.//")
  box_file="${base_name}.box"

  if [ ! -e "$box_file" ]; then
    ln -sf $box Vagrantfile

    vagrant destroy
    vagrant up
    echo "You'll now be dropped into an interactive shell in $base_name."
    echo "Make whatever changes are necessary and when you exit we'll repackage the box."
    vagrant ssh

    rm -f "$box_file"
    vagrant package --base "laptop-$base_name" --output "$box_file"

  else
    echo "$base_name already packaged at $box_file, skipping"
  fi
done

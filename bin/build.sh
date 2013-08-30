#!/bin/sh

for MANIFEST in Manifest.*; do
  FILENAME=$(printf "$MANIFEST" | sed s/Manifest\.//)
  rm -f "$FILENAME"

  printf "\nBuilding $MANIFEST into $FILENAME\n"

  while read file; do
    printf "Including: $file\n"

    cat "$file" >> "$FILENAME"

    printf "### end $file\n\n" >> "$FILENAME"
  done < "$MANIFEST"
done

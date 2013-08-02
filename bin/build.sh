#!/bin/sh

for MANIFEST in Manifest.*; do
  FILENAME=`echo -n "$MANIFEST" | sed s/Manifest\.//`
  rm -f $FILENAME

  echo "\nBuilding $MANIFEST into $FILENAME"

  for file in `cat $MANIFEST`; do
    echo "Including: $file"

    cat $file >> $FILENAME

    echo "### end $file\n" >> $FILENAME
  done

  chmod 755 $FILENAME
done

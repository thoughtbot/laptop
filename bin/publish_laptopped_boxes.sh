#!/bin/sh

check_for_aws() {
  if ! command -v aws >/dev/null; then
    failure_message 'You must install aws-cli to publish boxes'
    exit 1
  fi
}

message() {
  printf "\e[1;34m:: \e[1;37m%s\e[0m\n" "$*"
}

failure_message() {
  printf "\n\e[1;31mFAILURE\e[0m: \e[1;37m%s\e[0m\n\n" "$*" >&2;
}

upload_box_to_temp_location(){
  message "Uploading box to s3: $box"
  aws s3 cp "$box" "s3://laptop-boxes/$box.tmp" --acl public-read
}

move_box_into_place(){
  message "Removing existing box: $box"
  aws s3 rm "s3://laptop-boxes/$box" \
    || failure_message "Could not remove $box"

  message "Moving new box to correct location: $box"
  aws s3 mv "s3://laptop-boxes/$box.tmp" "s3://laptop-boxes/$box" \
    --acl public-read || failure_message 'Could not move new box into place on s3'
}

publish_box(){
  upload_box_to_temp_location && move_box_into_place
}

box_has_changed() {
  local remote_size=$(aws s3 ls "laptop-boxes/$box" | sed "s/  / /" | cut -f 3 -d ' ')
  local local_size=$(stat -c %s "$box")

  [ "$local_size" != "$remote_size" ]
}

###################################

check_for_aws

for box in *.box; do
  if [ -e "$box" ]; then
    if box_has_changed; then
      echo "local copy of $box has a different size than the s3 remote copy, publishing"
      publish_box
    else
      echo "local copy of $box has the same size as the s3 remote copy, not publishing"
    fi
  fi
done

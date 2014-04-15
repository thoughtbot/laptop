#!/usr/bin/env sh
source ./test/common

upload_box_to_temp_location(){
  message "Uploading box to s3: $BOX_NAME"
  aws s3 cp "$BOX_NAME" "s3://laptop-boxes/$BOX_NAME.tmp" --acl public-read
}

move_box_into_place(){
  message "Removing existing box: $BOX_NAME"
  aws s3 rm "s3://laptop-boxes/$BOX_NAME" \
    || failure_message "Could not remove $BOX_NAME"

  message "Moving new box to correct location: $BOX_NAME"
  aws s3 mv "s3://laptop-boxes/$BOX_NAME.tmp" "s3://laptop-boxes/$BOX_NAME" \
    --acl public-read || failure_message 'Could not move new box into place on s3'
}

remove_test_success_tracker(){
  rm "./test/succeeded.$LAPTOP_BASENAME"
}

publish_box(){
  set_box_names

  upload_box_to_temp_location && \
    move_box_into_place && \
    remove_test_success_tracker
}

check_for_aws

for vagrantfile in test/succeeded.*; do
  if [ -e "$vagrantfile" ]; then
    publish_box
  fi
done

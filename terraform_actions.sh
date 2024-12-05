#!/bin/bash

case "$1" in
  apply)
    terraform apply -auto-approve \
      -var="aws_region=us-east-1" \
      -var="create_ec2=false" \
      -var="create_s3=false" \
      -var="create_autoscaling=false" \
      -var="ami_id=ami-0453ec754f44f9a4a" \
      -var="instance_type=t2.micro" \
      -var="subnet_id=subnet-00c22c9ec69ab8e47" \
      -var="security_group_id=sg-0cec77f0a31766efb" \
      -var="s3_bucket_name=example-bucket"
    ;;

  destroy_ec2)
    terraform state list | grep "aws_instance.main" > /dev/null
    if [ $? -eq 0 ]; then
      terraform destroy -auto-approve \
        -var="aws_region=us-east-1" \
        -var="subnet_id=subnet-00c22c9ec69ab8e47" \
        -var="security_group_id=sg-0cec77f0a31766efb" \
        -target=aws_instance.main
    else
      echo "Resource aws_instance.main not found in state. Skipping destroy."
    fi
    ;;

  destroy_s3)
    terraform state list | grep "aws_s3_bucket.main" > /dev/null
    if [ $? -eq 0 ]; then
      terraform destroy -auto-approve \
        -var="aws_region=us-east-1" \
        -var="s3_bucket_name=example-bucket" \
        -target=aws_s3_bucket.main
    else
      echo "Resource aws_s3_bucket.main not found in state. Skipping destroy."
    fi
    ;;

  destroy_autoscaling)
    terraform state list | grep "aws_autoscaling_group.main" > /dev/null
    if [ $? -eq 0 ]; then
      terraform destroy -auto-approve \
        -var="aws_region=us-east-1" \
        -target=aws_autoscaling_group.main
    else
      echo "Resource aws_autoscaling_group.main not found in state. Skipping destroy."
    fi
    ;;

  destroy_all)
    terraform destroy -auto-approve \
      -var="aws_region=us-east-1" \
      -var="create_ec2=false" \
      -var="create_s3=false" \
      -var="create_autoscaling=false" \
      -var="ami_id=ami-0453ec754f44f9a4a" \
      -var="instance_type=t2.micro" \
      -var="subnet_id=subnet-00c22c9ec69ab8e47" \
      -var="security_group_id=sg-0cec77f0a31766efb" \
      -var="s3_bucket_name=example-bucket"
    ;;

  *)
    echo "Invalid terraform_action. Exiting."
    exit 1
    ;;
esac

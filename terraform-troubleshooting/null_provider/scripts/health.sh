#!/bin/bash
echo "   -------------------------------- "
echo "  --> Fetching Instance status."
sleep 25
instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=TheFastestManAlive" "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].InstanceId' --output text)
size=${#instance_id}
echo "  --> Instance ID: $instance_id"
sleep 2
instance_state=$(aws ec2 describe-instance-status --instance-ids $instance_id --query 'InstanceStatuses[*].InstanceState.Name' --output text)
size=${#instance_state}
echo "  --> Instance Status: $instance_state"
sleep 2
instance_zone=$(aws ec2 describe-instance-status --instance-ids $instance_id --query 'InstanceStatuses[*].AvailabilityZone' --output text)
size=${#instance_zone}
echo "  --> Availability Zone: $instance_zone"
sleep 2
fetch_instance_health=$(aws ec2 describe-instance-status --instance-ids $instance_id --query 'InstanceStatuses[*].InstanceStatus.Status' --output text)
echo "  --> Instance health check : $fetch_instance_health"
echo "  -------------------------------------------"

#!/bin/bash -e

MODE=$1
PLAN_PATH=tfplan

init() {
    echo "Running Terraform Init..."
    terraform init
    tflint --init
    echo "Init Successful!"
}

validate() {
    echo "Running Terraform validation..."
    terraform validate
    tflint
    echo "Validation Successful!"
}

plan_and_apply() {
    echo "Running Terraform Plan..."
    terraform plan \
        -out=$PLAN_PATH
    echo "Plan Successful!"

    echo "Running Terraform Apply..."
    terraform apply \
        $PLAN_PATH
    echo "Apply Successful!"
}

plan_and_destroy() {
    echo "Running Terraform Plan Destroy..."
    terraform plan \
        -destroy \
        -out=$PLAN_PATH
    echo "Plan Destroy Successful!"

    echo "Running Terraform Apply Destroy..."
    terraform apply \
        -destroy \
        $PLAN_PATH
    echo "Apply Destroy Successful!"
}

case $MODE in
prepare)
    command="init"
    ;;
check)
    command="validate"
    ;;
up)
    command="plan_and_apply"
    ;;
save)
    command="ssh_and_save"
    ;;
down)
    command="plan_and_destroy"
    ;;
esac

$command

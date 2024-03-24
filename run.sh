env=$1
action=$2

if [ -z $env ]; then
 echo "Env is missing"
 exit1
fi

if [ -z $action ]; then
 echo "Action is missing"
 exit1
fi

rm -rf .terraform/terraform.tfstate
terraform init -backend-config=env-$env/state.tfvars
terraform $action -var-file=env-$env/main.tfvars -auto-approve
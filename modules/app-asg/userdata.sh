#!/bin/bash

pip3.11 install ansible hvac
ansible-pull -i localhost, -U https://github.com/PrakharDevOpsLearning/expense-ansible get-secrets.yml -e env=${env} -e role_name=${component} -e vault_token=${vault_token}  &>>/opt/ansible.log
ansible-pull -i localhost, -U https://github.com/PrakharDevOpsLearning/expense-ansible expense.yml -e env=${env} -e role_name=${component} -e @~/secrets.json  &>>/opt/ansible.log
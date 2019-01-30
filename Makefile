SHELL := /bin/bash

users:
	terraform apply -state=users/tf.state users

users-destroy:
	terraform destroy -state=users/tf.state users

prod:
	source <(bin/prod_env) && terraform apply -state=prod/tf.state prod

prod-destroy:
	source <(bin/prod_env) && terraform destroy -state=prod/tf.state prod

destroy: prod-destroy users-destroy

.PHONY: users prod

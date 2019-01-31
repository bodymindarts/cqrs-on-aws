users:
	terraform apply -state=infra/users/tf.state infra/users

users-destroy:
	terraform destroy -state=infra/users/tf.state infra/users

prod:
	export $$(bin/prod_env); terraform apply -state=infra/environment/tf.state infra/environment

prod-destroy:
	export $$(bin/prod_env); terraform destroy -state=infra/environment/tf.state infra/environment

destroy: prod-destroy users-destroy

.PHONY: users prod

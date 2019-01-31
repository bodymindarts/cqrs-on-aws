users:
	terraform apply -state=users/tf.state users

users-destroy:
	terraform destroy -state=users/tf.state users

prod:
	export $$(bin/prod_env); terraform apply -state=environment/tf.state environment

prod-destroy:
	export $$(bin/prod_env); terraform destroy -state=environment/tf.state environment

destroy: prod-destroy users-destroy

.PHONY: users prod

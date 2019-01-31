all: users prod

users:
	terraform apply -state=infra/users/tf.state infra/users

users-destroy:
	terraform destroy -state=infra/users/tf.state infra/users

prod: package
	export $$(bin/prod_env); terraform apply -state=infra/environment/tf.state infra/environment

prod-destroy:
	export $$(bin/prod_env); terraform destroy -state=infra/environment/tf.state infra/environment

package:
	bin/package_lambda.sh hello_world
destroy: prod-destroy users-destroy


.PHONY: users prod

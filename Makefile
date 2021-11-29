setup: ansible-galaxy-install
	touch vault-password

ansible-playbook:
	ansible-playbook -i inventory.ini playbook.yml --vault-pass-file vault-password

ansible-galaxy-install:
	ansible-galaxy install role -r requirements.yml
	ansible-galaxy install -r requirements.yml

encrypt-vault:
	ansible-vault encrypt --vault-password-file vault-password group_vars/webservers/vault.yml

decrypt-vault:
	ansible-vault decrypt --vault-password-file vault-password group_vars/webservers/vault.yml

ssh-server1:
	ssh root@104.131.46.61

ssh-server2:
	ssh root@143.198.19.134

deploy: ansible-playbook

check:
	ansible-playbook -vvvv --syntax-check -i inventory.ini playbook.yml

docker-ansible:
	docker run --rm -it --platform linux/amd64 -v $(HOME)/.ssh:/root/.ssh -v $(PWD):/ansible willhallonline/ansible /bin/sh

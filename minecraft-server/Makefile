.PHONY: prepare, check, up, save, down, inside

PEM_FILE = ~/.ssh/id_rsa
INSTANCE_USER_NAME = ubuntu

prepare:
	./scripts/deployment.sh prepare

check:
	./scripts/deployment.sh check

up:
	./scripts/deployment.sh up

save:
	./scripts/deployment.sh save

down:
	./scripts/deployment.sh down

inside:
	ssh -i $(PEM_FILE) $(INSTANCE_USER_NAME)@$(NODE_IP)

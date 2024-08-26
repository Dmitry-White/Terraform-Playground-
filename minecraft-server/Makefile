.PHONY: prepare, check, up, save, down, inside

INSTANCE_USER_NAME = ubuntu
GAME_SAVE_SCRIPT = ./scripts/game_save.sh

prepare:
	./scripts/deployment.sh prepare

check:
	./scripts/deployment.sh check

up:
	./scripts/deployment.sh up

down:
	./scripts/deployment.sh down

save:
	ssh -i \
		$(PEM_FILE) \
		$(INSTANCE_USER_NAME)@$(NODE_IP) \
		'bash -s' \
		< $(GAME_SAVE_SCRIPT) $(SERVER_BUCKET) $(SERVER_FOLDER)

ssl:
	ssh-keygen \
		-f $(PEM_FILE) \
		-N $(PEM_FILE_PASSWORD)

inside:
	ssh -i \
		$(PEM_FILE) \
		$(INSTANCE_USER_NAME)@$(NODE_IP)

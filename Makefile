export PROJECT=savefileparseapi
export DOCKER_IMAGE=${PROJECT}:latest
export SERVICE=app
export PORT ?= 5212

test:
	curl --location 'http://localhost:${PORT}/api/v1/RawDatabaseImage' --data-binary "@../savegame/HL-01-00.sav" -X POST

 
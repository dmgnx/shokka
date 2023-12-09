.PHONY: shokka.sh

all: shokka.sh

shokka.sh:
	@mv shokka.sh shokka_.sh
	@chmod +x shokka_.sh
	@./shokka_.sh shokka\~.sh
	@rm shokka_.sh
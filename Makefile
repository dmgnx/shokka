all: shokka.sh

shokka.sh: shokka~.sh
	@mv shokka.sh shokka_.sh
	@chmod +x shokka_.sh
	@./shokka_.sh shokka\~.sh
	@rm shokka_.sh

examples: $(patsubst examples/%~.sh,examples/%.sh,$(wildcard examples/*.sh))

examples/%.sh: examples/%~.sh
	@./shokka.sh $<

BIN ?= rtail
PREFIX ?= /usr/local
MANPREFIX ?= $(PREFIX)/share/man/man1

$(BIN): test man

.PHONY: coverage

fake-ssh-server:
	docker rm -f fake-ssh-server || true
	docker run --name fake-ssh-server -p 22222:22 -v $(PWD):$(PWD) --rm -d javanile/fake-ssh-server

test: fake-ssh-server
	./test.sh

install:
	cp rtail.sh $(PREFIX)/bin/$(BIN)
	cp rtail.1 $(MANPREFIX)/$(BIN).1

uninstall:
	rm -f $(PREFIX)/bin/$(BIN)
	rm -f $(MANPREFIX)/$(BIN).1

man:
	@curl -# -F page=@rtail.1.md -o rtail.1 http://mantastic.herokuapp.com
	@echo "rtail.1"

coverage: fake-ssh-server
	curl -fsSL git.io/lcov.sh | bash -s -- test.sh

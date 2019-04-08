freebsd:
	./packer.sh build freebsd.json

validate:
	./packer.sh validate freebsd.json

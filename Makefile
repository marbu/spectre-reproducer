.PHONY: clean

spectre: spectre.c
	gcc -march=native -std=c99 -O0 $? -o $@

clean:
	rm -rf spectre

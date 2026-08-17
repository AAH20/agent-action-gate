.PHONY: test bench run demo

test:
	PYTHONPATH=. python3 -m unittest discover -s tests -v

bench:
	PYTHONPATH=. python3 -m aag bench

run:
	PYTHONPATH=. python3 -m aag demo

demo: test bench run

.PHONY: test bench run demo serve

test:
	PYTHONPATH=. python3 -m unittest discover -s tests -v

bench:
	PYTHONPATH=. python3 -m aag bench

run:
	PYTHONPATH=. python3 -m aag demo

serve:
	PYTHONPATH=. python3 -m aag serve

demo: test bench run

.PHONY: test bench run demo serve pack-mcpb

test:
	PYTHONPATH=. python3 -m unittest discover -s tests -v

bench:
	PYTHONPATH=. python3 -m aag bench

run:
	PYTHONPATH=. python3 -m aag demo

serve:
	PYTHONPATH=. python3 -m aag serve

pack-mcpb:
	mkdir -p artifacts
	rm -f artifacts/agent-action-gate.mcpb
	COPYFILE_DISABLE=1 zip -r artifacts/agent-action-gate.mcpb \
		manifest.json aag fixtures README.md LICENSE SECURITY.md pyproject.toml \
		-x "*.pyc" "*__pycache__*"
	openssl dgst -sha256 artifacts/agent-action-gate.mcpb

demo: test bench run

.PHONY : doc clean
PYTHON ?= python
PYTEST ?= pytest


all:

setup-dev:
	pip install -r requirements.txt

build: 
	python setup.py build_ext

clean:
	$(PYTHON) setup.py clean

doc:
	-rm -rf doc/build doc/source/generated
	cd doc; \
	$(MAKE) html

render-doc: doc
	python -m http.server --directory doc/build/html

dev: build
	python -m pip install --no-build-isolation -e .

test-cov:
	rm -rf coverage .coverage
	$(PYTEST) pythontemplate --showlocals -v

test: test-cov

tidy:
	black . -l 120
	tidy-imports . -r

install: 
	pip install .

lint:
	flake8
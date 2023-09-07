all: pres.pdf

pres.pdf:
	docker run --rm -ti -v $$(pwd):/data nemanjan00/pandoc pandoc -t beamer README.md -o pres.pdf

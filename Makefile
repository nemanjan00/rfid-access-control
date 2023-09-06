all: pres.pdf

pres.pdf:
	docker run --rm -ti -v $$(pwd):/data yackx/pandoc pandoc -t beamer README.md -o pres.pdf

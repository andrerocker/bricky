build:
	gem build bricky.gemspec

push: build
	gem push $(shell ls *.gem | tail -1)

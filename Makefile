
IMAGE	= andrelucas/fio
TAG		= latest

all: fio image push

.PHONY: image push

fio:
	dapper

image:
	docker build -t $(IMAGE):$(TAG) --rm .

push:
	docker push $(IMAGE):$(TAG)

clean:
	rm -f fio

distclean:
	docker rmi $(IMAGE):$(TAG)

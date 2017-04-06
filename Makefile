include config.mk
DATE = `date +'%Y%m%d'`

COMMIT_MESSAGE = $(GH_NAME)
COMMIT_MESSAGE += $(DEV_MESSAGE)
COMMIT_MESSAGE += `date +'%y%m%d%H%M%S'`


dummy:
	echo "test"

symlink:
	for file in $(ls /usr/include/lua5.2/); do sudo ln -s /usr/include/lua5.2/$file /usr/include/$file; done

clone:
	\git clone git@github.com:$(GH_NAME)/valair || \git clone https://github.com/$(GH_NAME)/valair || git clone https://github.com/cmotc/valair; \
	\git clone git@github.com:$(GH_NAME)/sdl2-vapi || \git clone https://github.com/$(GH_NAME)/sdl2-vapi || git clone https://github.com/cmotc/sdl2-vapi; \
	\git clone git@github.com:$(GH_NAME)/tox-vapi || \git clone https://github.com/$(GH_NAME)/tox-vapi || git clone https://github.com/cmotc/tox-vapi; \
	\git clone git@github.com:$(GH_NAME)/tartrazine || \git clone https://github.com/$(GH_NAME)/tartrazine || git clone https://github.com/cmotc/tartrazine; \
	\git clone git@github.com:$(GH_NAME)/lairart || \git clone https://github.com/$(GH_NAME)/lairart || git clone https://github.com/cmotc/lairart; \
	\git clone git@github.com:$(GH_NAME)/lair-deb || \git clone https://github.com/$(GH_NAME)/lair-deb || git clone https://github.com/cmotc/lair-deb; \
	\git clone git@github.com:$(GH_NAME)/lair-msi || \git clone https://github.com/$(GH_NAME)/lair-msi || git clone https://github.com/cmotc/lair-msi; \
	\git clone git@github.com:$(GH_NAME)/lair-web || \git clone https://github.com/$(GH_NAME)/lair-web || git clone https://github.com/cmotc/lair-web; \
	echo "Cloned subprojects"

deinit:
	 \git remote remove github
	cd valair && \git remote remove github
	cd sdl2-vapi && \git remote remove github
	cd tox-vapi && \git remote remove github
	cd tartrazine && \git remote remove github
	cd lairart && \git remote remove github
	cd lair-deb && \git remote remove github
	cd lair-msi && \git remote remove github
	cd lair-web && \git remote remove github
	echo "removed pre-init"

init:
	make init-upstream; \
	\git remote add github git@github.com:$(GH_NAME)/lair-manifest
	cd valair && \git remote add github git@github.com:$(GH_NAME)/valair
	cd sdl2-vapi && \git  remote add github git@github.com:$(GH_NAME)/sdl2-vapi
	cd tox-vapi && \git  remote add github git@github.com:$(GH_NAME)/tox-vapi
	cd tartrazine && \git  remote add github git@github.com:$(GH_NAME)/tartrazine
	cd lairart && \git  remote add github git@github.com:$(GH_NAME)/lairart
	cd lair-deb && \git  remote add github git@github.com:$(GH_NAME)/lair-deb
	cd lair-msi && \git  remote add github git@github.com:$(GH_NAME)/lair-msi
	cd lair-web && \git  remote add github git@github.com:$(GH_NAME)/lair-web
	echo "Initialized Working Remotes"
	make checkout

init-upstream:
	\git remote add upstream git@github.com:cmotc/lair-manifest; \
	cd valair && \git remote add upstream git@github.com:cmotc/valair
	cd sdl2-vapi && \git  remote add upstream git@github.com:cmotc/sdl2-vapi
	cd tox-vapi && \git  remote add upstream git@github.com:cmotc/tox-vapi
	cd tartrazine && \git  remote add upstream git@github.com:cmotc/tartrazine
	cd lairart && \git  remote add upstream git@github.com:cmotc/lairart
	cd lair-deb && \git  remote add upstream git@github.com:cmotc/lair-deb
	cd lair-msi && \git  remote add upstream git@github.com:cmotc/lair-msi
	cd lair-web && \git  remote add upstream git@github.com:cmotc/lair-web
	echo "Initialized Upstream Remotes"

checkout:
	\git checkout master
	cd valair && \git  checkout mobs
	cd sdl2-vapi && \git  checkout master
	cd tox-vapi && \git  checkout master
	cd tartrazine && \git  checkout master
	cd lairart && \git  checkout gh-pages
	cd lair-deb && \git  checkout gh-pages
	cd lair-msi && \git  checkout master
	cd lair-web && \git  checkout master

commit:
	cd valair && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
	cd ../sdl2-vapi && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
	cd ../tox-vapi && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
	cd ../tartrazine && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
	cd ../lairart && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
	cd ../lair-deb && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
	cd ../lair-msi && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
	cd ../lair-web && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
	cd .. && \git add . && \git commit -am "${COMMIT_MESSAGE}m"; \
	echo "Committed Release:"
	echo "${COMMIT_MESSAGE}"

fetch:
	\git rebase upstream/master; \
	cd valair && \git rebase upstream/mobs; \
	cd ../sdl2-vapi && \git rebase upstream/master; \
	cd ../tox-vapi && \git rebase upstream/master; \
	cd ../tartrazine && \git rebase upstream/master; \
	cd ../lairart && \git rebase upstream/gh--pages; \
	cd ../lair-deb && \git rebase upstream/gh-pages; \
	cd ../lair-msi && \git rebase upstream/master; \
	cd ../lair-web && \git rebase upstream/master; \
	echo "Pulled in updates"

pull:
	make commit
	make fetch

update:
	make commit
	repo sync --force-sync || make fetch

force-update:
	make clean; \
	rm -rf */* */.git */.repo .git/; \
	repo sync --force-sync || make fetch \
	make init

upload:
	\git push github master; \
	cd valair && \git push github mobs; \
	cd ../sdl2-vapi && \git push github master; \
	cd ../tox-vapi && \git push github master; \
	cd ../tartrazine && \git push github master; \
	cd ../lairart && \git push github gh-pages; \
	cd ../lair-deb && \git push github gh-pages; \
	cd ../lair-msi && \git push github master; \
	cd ../lair-web && \git push github master;
	echo "Pushed Working Updates"

clean:
	cd valair && make clean; \
	cd ../sdl2-vapi && make clean; \
	cd ../tox-vapi && make clean; \
	cd ../tartrazine && make clean; \
	cd ../lairart && make clean; \
	cd ../lair-deb && make clean; \
	cd ../lair-msi && make clean; \
	cd ../lair-web && make clean; \
	cd .. && rm *.buildinfo *.changes *.deb *.deb.md *.dsc *.tar.xz *.tar.gz *.debian.tar.xz *.debian.tar.gz *.orig.tar.gz *.orig.tar.zz; \
	echo "Finished cleaning"

lair:
	export VERSION=$(VERSION);cd valair && make deb-pkg || make deb-upkg
	cd valair && make windows

update-lair:
	export VERSION=$(VERSION);cd valair &&\git add . && \git commit -am "${COMMIT_MESSAGE}"; \
		\git push github mobs

sdl2:
	export VERSION=$(VERSION);cd sdl2-vapi && make deb-pkg

update-sdl2:
	export VERSION=$(VERSION);cd sdl2-vapi && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
		\git push github master

tox:
	export VERSION=$(VERSION);cd tox-vapi && make deb-pkg

update-tox:
	export VERSION=$(VERSION);cd tox-vapi && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
		\git push github master

yellow:
	export VERSION=$(VERSION);cd tartrazine && make deb-pkg

update-yellow:
	export VERSION=$(VERSION);cd tartrazine && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
		\git push github master

art:
	export VERSION=$(VERSION);cd lairart && make && make deb-pkg || make deb-upkg
	cd lairart && make windows;

update-art:
	export VERSION=$(VERSION);cd lairart && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
		\git push github gh-pages

msi:
	export VERSION=$(VERSION);cd lair-msi && make windows

update-msi:
	export VERSION=$(VERSION);cd lair-msi && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
		\git push github master

web:
	export VERSION=$(VERSION);
	echo "True"
	rm -rf lair-web/lair-deb
	cp -R lair-deb lair-web/lair-deb
	rm -rf lair-web/lair-deb/.git
	cd lair-web && make && git add . && git commit -am "new webpage ${COMMIT_MESSAGE}" && git push github master

update-web:
	export VERSION=$(VERSION);cd lair-web && \git add . && \git commit -am "${COMMIT_MESSAGE}"; \
		\git push github master

deb:
	cp lair_$(VERSION)-1_amd64.buildinfo \
		lair_$(VERSION)-1_amd64.changes \
		lair_$(VERSION)-1_amd64.deb \
		lair_$(VERSION)_amd64.deb.md \
		lair_$(VERSION)-1.debian.tar.xz \
		lair_$(VERSION)-1.dsc \
		lair_$(VERSION).orig.tar.gz \
		lair-dbgsym_$(VERSION)-1_amd64.deb \
		lair-dbgsym_$(VERSION)-1_amd64.deb.md \
		sdl2-vapi_2.0-1_amd64.deb \
		tartrazine_0.9-1_amd64.deb \
		tox-vapi_0.9-1_amd64.deb \
		lair-deb/packages; \
	cp lairart_$(VERSION)-1_amd64.buildinfo \
		lairart_$(VERSION)-1_amd64.changes \
		lairart_$(VERSION)-1_amd64.deb \
		lairart_$(VERSION)-1.debian.tar.xz \
		lairart_$(VERSION)-1.dsc \
		lairart_$(VERSION)-1.orig.tar.gz \
		lair-dbgsym_$(VERSION)_amd64.deb \
		lair-deb/packages; \
	cd lair-deb && ./apt-now

full:
	make lair
	make sdl2
	make tox
	make yellow
	make art
	make msi
	make deb
	make web
	echo "Rebuilt the whole suite"

push:
	make commit
	make upload

release:
	make full
	make push
	repo sync

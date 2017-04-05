DATE = `date +'%Y%m%d'`
GVERSION = '9.1'
VERSION = '9.1'

COMMIT_MESSAGE = `date +'%y-%m-%d-%H-%M-%S'`

dummy:
	echo "test"

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
	\git remote add github git@github.com:cmotc/lair-manifest
	cd valair && \git remote add github git@github.com:cmotc/valair
	cd sdl2-vapi && \git  remote add github git@github.com:cmotc/sdl2-vapi
	cd tox-vapi && \git  remote add github git@github.com:cmotc/tox-vapi
	cd tartrazine && \git  remote add github git@github.com:cmotc/tartrazine
	cd lairart && \git  remote add github git@github.com:cmotc/lairart
	cd lair-deb && \git  remote add github git@github.com:cmotc/lair-deb
	cd lair-msi && \git  remote add github git@github.com:cmotc/lair-msi
	cd lair-web && \git  remote add github git@github.com:cmotc/lair-web
	echo "Initialized Working Remotes"

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
	cd .. && \git add . && \git commit -am "${COMMIT_MESSAGE}"
	echo "Committed Release:"
	echo "${COMMIT_MESSAGE}"

update:
	cd valair && \git push github mobs
	cd sdl2-vapi && \git push github master
	cd tox-vapi && \git push github master
	cd tartrazine && \git push github master
	cd lairart && \git push github gh-pages
	cd lair-deb && \git push github gh-pages
	cd lair-msi && \git push github master
	cd lair-web && \git push github master
	\git push github master
	echo "Pushed Working Updates"

clean:
	cd valair && make clean; \
	cd ../sdl2-vapi && make clean; \
	cd ../tox-vapi && make clean; \
	cd ../tartrazine && make clean; \
	cd ../lairart && make clean; \
	cd ../lair-deb && make clean; \
	cd ../lair-msi && make clean; \
	cd ../lair-web && make clean
	rm *.buildinfo *.changes *.deb *.deb.md *.tar.xz *.dsc
	echo "Finished cleaning"

lair:
	cd valair && make deb-pkg; make windows

sdl2:
	cd sdl2-vapi && make deb-pkg

tox:
	cd tox-vapi && make deb-pkg

yellow:
	cd tartrazine && make deb-pkg

art:
	cd lairart && make deb-pkg; make windows;

msi:
	cd lair-msi && make windows

web:
	echo "True"
	rm -rf lair-web/lair-deb
	cp -R lair-deb lair-web/lair-deb
	rm -rf lair-web/lair-deb/.git
	cd lair-web && make && git add . && git commit -am "new webpage" && git push origin master

deb:
	cp lair_$(GVERSION)-1_amd64.buildinfo \
		lair_$(GVERSION)-1_amd64.changes \
		lair_$(GVERSION)-1_amd64.deb \
		lair_$(GVERSION)-1_amd64.deb.md \
		lair_$(GVERSION)-1.debian.tar.xz \
		lair_$(GVERSION)-1.dsc \
		lair_$(GVERSION).orig.tar.gz \
		lair-dbgsym_$(GVERSION)-1_amd64.deb \
		lair-dbgsym_$(GVERSION)-1_amd64.deb.md \
		sdl2-vapi_2.0-1_amd64.deb \
		tartrazine_0.9-1_amd64.deb \
		tox-vapi_0.9-1_amd64.deb \
		lair-deb/packages
	cp lairart_$(VERSION)-1_amd64.buildinfo \
		lairart_$(VERSION)-1_amd64.changes \
		lairart_$(VERSION)-1_amd64.deb \
		lairart_$(VERSION)-1.debian.tar.xz \
		lairart_$(VERSION)-1.dsc \
		lairart_$(VERSION).orig.tar.gz \
		lair-dbgsym_$(VERSION)-1_amd64.deb \
		sdl2-vapi_2.0-1_amd64.deb \
		lair-deb/packages
	cd lair-deb && apt-now

full:
	make lair
	make sdl2
	make tox
	make yellow
	make art
	make msi
	make deb
	make web
	make commit
	make update


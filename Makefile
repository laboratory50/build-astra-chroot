LAB50_MIRROR=http://packages/pub/$(DIST)
HOOKDIR=$(HOME)/.local/share/pbuilder/hooks

ENVS=$(patsubst env/%, %, $(wildcard env/*))
PBUILDERRC=$(HOME)/.pbuilderrc

install:
	install data/se14 /usr/share/debootstrap/scripts
	install -m 0440 data/sudoers /etc/sudoers.d/pbuilder

$(PBUILDERRC): pbuilderrc.in
	@cp $< $@
	@sed -i '/HOOKDIR=/c\HOOKDIR=$(HOOKDIR)/\$$ENV' $@
	@sed -i 's/#export LD_PRELOAD/export LD_PRELOAD/' $@
	@echo "~/.pbuilderrd updated"

update: $(PBUILDERRC)
	@for env in $(ENVS); do \
	    mkdir -p $(HOOKDIR)/$$env; \
	    sh chook env/$$env $(HOOKDIR)/$$env; \
	done \

dist:
	export DIST=$(DIST)
	/usr/sbin/pbuilder --create --configfile pbuilderrc.in --hookdir hooks.d \
	    --buildplace /var/cache/pbuilder/base-$(DIST).cow --distribution smolensk \
	    --othermirror "deb $(LAB50_MIRROR) stable main" --no-targz

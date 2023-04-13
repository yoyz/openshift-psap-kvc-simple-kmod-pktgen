obj-m += pktgen.o

ifndef KVER
KVER=$(shell uname -r)
endif

ifndef KMODVER
KMODVER=$(shell git describe HEAD 2>/dev/null || git rev-parse --short HEAD)
endif

all:
	make -C /lib/modules/$(KVER)/build M=$(PWD) EXTRA_CFLAGS=-DKMODVER=\\\"$(KMODVER)\\\" modules
clean:
	make -C /lib/modules/$(KVER)/build M=$(PWD) clean
install:
	install -v -m 755 -d /lib/modules/$(KVER)/
	install -v -m 644 pktgen.ko        /lib/modules/$(KVER)/pktgen.ko
	depmod -F /lib/modules/$(KVER)/System.map $(KVER)

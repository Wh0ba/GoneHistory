ARCHS = arm64

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = gonehistory
gonehistory_FILES = $(wildcard *.m)
gonehistory_FRAMEWORKS = UIKit CoreGraphics

gonehistory_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/application.mk


package::
	packages/dab
	open com.wh0ba.gonehistory


after-install::
	install.exec "killall \"gonehistory\"" || true

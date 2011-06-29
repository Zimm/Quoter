TARGET_IPHONEOS_DEPLOYMENT_VERSION=4.0

TWEAK_NAME = Quoter
Quoter_FILES = Tweak.xm
Quoter_FRAMEWORKS = Foundation UIKit
Quoter_LDFLAGS = -lsqlite3

include theos/makefiles/common.mk
include theos/makefiles/tweak.mk

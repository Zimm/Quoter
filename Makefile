TARGET_IPHONEOS_DEPLOYMENT_VERSION=4.0

TWEAK_NAME = Quoter
Quoter_FILES = Tweak.xm
Quoter_FRAMEWORKS = Foundation UIKit
Quoter_LDFLAGS = -lsqlite3

include framework/makefiles/common.mk
include framework/makefiles/tweak.mk

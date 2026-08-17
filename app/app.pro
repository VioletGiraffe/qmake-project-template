###################################################
#            Basic configuration
###################################################

TEMPLATE = app
TARGET   = NewAwesomeApplication

#QT = core gui widgets network qt5compat
CONFIG -= qt
CONFIG += console

include(../global.pri)

Release:OUTPUT_DIR=release/
Debug:OUTPUT_DIR=debug/

DESTDIR  = ../bin/$${OUTPUT_DIR}
OBJECTS_DIR = ../build/$${OUTPUT_DIR}/$${TARGET}
MOC_DIR     = ../build/$${OUTPUT_DIR}/$${TARGET}
UI_DIR      = ../build/$${OUTPUT_DIR}/$${TARGET}
RCC_DIR     = ../build/$${OUTPUT_DIR}/$${TARGET}

###################################################
#               INCLUDEPATH
###################################################

INCLUDEPATH += \
	../qtutils \
	../cpputils \
	../cpp-template-utils

###################################################
#                 SOURCES
###################################################

SOURCES += \
	src/main.cpp

###################################################
#                 LIBS
###################################################

LIBS += -L$${DESTDIR} -lcpputils

mac*|linux*|freebsd*{
	PRE_TARGETDEPS += $${DESTDIR}/libcpputils.a
}

###################################################
#    Platform-specific compiler options and libs
###################################################

win*{
	#LIBS += -lole32 -lShell32 -lUser32
	QMAKE_CXXFLAGS += /wd4251
}

mac*{
	LIBS += -framework AppKit

	QMAKE_POST_LINK = cp -f -p $${DESTDIR}/*.dylib $${DESTDIR}/$${TARGET}.app/Contents/MacOS/ || true
}


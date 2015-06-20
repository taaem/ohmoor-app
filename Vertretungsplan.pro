TEMPLATE = app

QT += qml quick widgets svg xml

SOURCES += main.cpp \
    requestplan.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    qml/pages/Base.qml \
    qml/pages/AboutPage.qml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += \
    requestplan.h

OTHER_FILES += qml/main.qml \
    qml/pages/Plan.qml \
    qml/pages/Ubersicht.qml \
    qml/pages/LoginPage.qml \
    qml/pages/Settings.qml \


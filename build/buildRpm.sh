#!/bin/bash
VERSION=$(npm version | grep f5-declarative-onboarding | cut -d : -f 2 | awk -F \' '{print $2}')
RELEASE=4
RPM_NAME=f5-declarative-onboarding-${VERSION}-${RELEASE}.noarch.rpm
rm -rf node_modules
npm install --production
rpmbuild -bb --define "main $(pwd)" --define '_topdir %{main}/build/rpmbuild' --define "_version ${VERSION}" --define "_release ${RELEASE}" build/f5-declarative-onboarding.spec
pushd build/rpmbuild/RPMS/noarch
sha256sum ${RPM_NAME} > ${RPM_NAME}.sha256
popd
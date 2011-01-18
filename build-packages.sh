#!/bin/sh
#
# Build font packages from the directories stored in the git tree.
# Packaging follows the canonical distribution layout from figlet.org

STAGE_DIR=.staging
PKG_DIR=pkg
FONTDIRS="
  C64-fonts
  Obanner
  Obanner-canon
  bdffonts
  cjkfonts
  contributed
  international
  jave
  ms-dos
  ours
  tlf-contrib
  toilet"

create_package() {
	dir=$1

	echo -n "Creating package $dir... "
	tar cf - $dir | gzip -9c > $dir.tar.gz
	echo done
}


rm -Rf $PKG_DIR
mkdir $PKG_DIR


for i in $FONTDIRS; do
	create_package $i
	mv $i.tar.gz $PKG_DIR/
done

ls -l $PKG_DIR/

#!/bin/sh
#
# Build font packages from the directories stored in the git tree.
# Packaging follows the canonical distribution layout from figlet.org

STAGE_DIR=.staging
PKG_DIR=pkg

create_package() {
	dir=$1

	echo -n "Creating package $dir... "
	tar cf - $dir | gzip -9c > $dir.tar.gz
	echo done
}


rm -Rf $STAGE_DIR $PKG_DIR
mkdir $STAGE_DIR $PKG_DIR


# Build canonical package layout

for i in contributed international jave ms-dos ours; do
	cp -rap $i $STAGE_DIR/
done

cp -rap C64-fonts Obanner.README bdffonts $STAGE_DIR/contributed
tar cf - Obanner | gzip -c > $STAGE_DIR/contributed/Obanner.tgz
tar cf - Obanner-canon | gzip -c > $STAGE_DIR/contributed/Obanner-canon.tgz

cp -rap cjkfonts.readme $STAGE_DIR/international
tar cf - cjkfonts | gzip -c > $STAGE_DIR/international/cjkfonts.tgz


# Create tarballs

(cd $STAGE_DIR
for i in contributed international jave ms-dos ours; do
	create_package $i
	mv $i.tar.gz ../$PKG_DIR
done)

ls -l $PKG_DIR/

# Remove temporary files

rm -Rf $STAGE_DIR

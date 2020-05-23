set -e

if [ -z "$MAKE" ]; then
	MAKE=make
fi
if [ -z "$M64P_COMPONENTS" ]; then
	M64P_COMPONENTS="core rom ui-console audio-sdl input-sdl rsp-hle video-rice video-glide64mk2"
fi

mkdir -p ./test/
MAKE_INSTALL="PLUGINDIR= SHAREDIR= BINDIR= MANDIR= LIBDIR= APPSDIR= ICONSDIR=icons INCDIR=api LDCONFIG=true "

for component in ${M64P_COMPONENTS}; do
	if [ "${component}" = "core" ]; then
		component_type="library"
	elif  [ "${component}" = "rom" ]; then
		echo "************************************ Building test ROM"
		mkdir -p ./test/
		cp source/mupen64plus-rom/m64p_test_rom.v64 ./test/
		continue
	elif  [ "${component}" = "ui-console" ]; then
		component_type="front-end"
	else
		component_type="plugin"
	fi

	echo "************************************ Building ${component} ${component_type}"
	"$MAKE" -C source/mupen64plus-${component}/projects/unix clean $@
	"$MAKE" -C source/mupen64plus-${component}/projects/unix all $@
	"$MAKE" -C source/mupen64plus-${component}/projects/unix install $@ ${MAKE_INSTALL} DESTDIR="$(pwd)/test/"

	mkdir -p ./test/doc
	for doc in LICENSES README RELEASE; do
		if [ -e "source/mupen64plus-${component}/${doc}" ]; then
			cp "source/mupen64plus-${component}/${doc}" "./test/doc/${doc}-mupen64plus-${component}"
		fi
	done
	for subdoc in gpl-license font-license lgpl-license module-api-versions.txt; do
		if [ -e "source/mupen64plus-${component}/doc/${subdoc}" ]; then
			cp "source/mupen64plus-${component}/doc/${subdoc}" ./test/doc/
		fi
	done
done

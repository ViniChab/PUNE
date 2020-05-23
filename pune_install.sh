set -e

if [ -z "$MAKE" ]; then
	MAKE=make
fi

if [ -z "$M64P_COMPONENTS" ]; then
	M64P_COMPONENTS="core rom ui-console audio-sdl input-sdl rsp-hle video-rice video-glide64mk2"
fi

for component in ${M64P_COMPONENTS}; do
	if [ "${component}" = "core" ]; then
		component_type="library"
	elif  [ "${component}" = "rom" ]; then
		continue
	elif  [ "${component}" = "ui-console" ]; then
		component_type="front-end"
	else
		component_type="plugin"
	fi

	echo "************************************ Installing ${component} ${component_type}"
	"$MAKE" -C source/mupen64plus-${component}/projects/unix install $@
done

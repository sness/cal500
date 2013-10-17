all: ../simpleplay.swf

install: ../simpleplay.swf
	cp ../simpleplay.swf ~/mDEV/orchive/public
	cp  library/* ~/mDEV/orchive/public/main/src/library

../simpleplay.swf: SimplePlay.hx SoundPlayer.hx PlayButton.hx VolumeSlider.hx VolumeButton.hx TimeIndicator.hx ProgressBar.hx simpleplay.hxml
	haxe simpleplay.hxml

swflib.swf: swflib.xml
	/usr/sness/haxe/bin/swfmill simple swflib.xml swflib.swf

//
// Simpleplay - A MP3 player that has a zoomable FFT spectrogram
// 
// Copyright 2008 - sness@sness.net - GPL V3
//
// Uses the Flash9 API
//


import flash.events.MouseEvent;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.events.IOErrorEvent;
import flash.display.Stage;
import flash.display.Sprite;
import flash.display.SimpleButton;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.net.URLRequest;

class SimplePlay
{
	static var globalWidth:Int = 500;
	static var globalHeight:Int = 220;

	static var r : SimplePlay;

	static var sound_player : SoundPlayer;
	static var play_button : PlayButton;
	static var volume_slider : VolumeSlider;
// 	static var brightness_slider : BrightnessSlider;
// 	static var contrast_slider : ContrastSlider;
	static var time_indicator : TimeIndicator;
	static var progress_bar : ProgressBar;
// 	static var zoomer : Zoomer;

	static var sound_state : Int;

	static var sound_position : Float; // the current playback position (0.0 - 1.0)
	static var sound_loaded : Float; // the amount of data that has been loaded (0.0 - 1.0)

	static var progress_bar_down : Bool;
// 	static var zoomer_down : Bool;

	public static var song_url : String; // The prefix of the filename we are loading

	function new() {
	}

	static function main ()
	{
//   		var i : Int = 0;
//   		while (i < 15) {
//   			trace(" ");
//   			i++;
//   		}

		// Figure out the prefix of the filename we are looking at
		if (flash.Lib.current.loaderInfo.parameters.song_url != null) {
			song_url = flash.Lib.current.loaderInfo.parameters.song_url;
		} else {
			// If is undefined, we are in the standalone player, so just choose
			// a favorite file for debugging.
			song_url = "/src/assets/a.mp3";
		}

		flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, mainMouseUp);
		flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, mainMouseDown);

		// Setup the main Timer object to run every 10ms
		var t = new haxe.Timer(100);
		t.run = onTimer;

		// The SoundPlayer that loads and plays the MP3 file
		sound_player = new SoundPlayer();
		sound_state = 0;
		sound_position = 0;
		sound_loaded = 0;

// 		// The zoom region
// 		zoomer = new Zoomer();
// 		flash.Lib.current.stage.addChild(zoomer);

		// The progress bar
 		progress_bar = new ProgressBar();
 		flash.Lib.current.stage.addChild(progress_bar);

		// The play/pause buttons
		play_button = new PlayButton();
		play_button.addEventListener(MouseEvent.CLICK, togglePlay);
		flash.Lib.current.stage.addChild(play_button);

		// The volume slider
		volume_slider = new VolumeSlider();
		flash.Lib.current.stage.addChild(volume_slider);

// 		// The brightness slider
// 		brightness_slider = new BrightnessSlider();
// 		flash.Lib.current.stage.addChild(brightness_slider);

// 		// The contrast slider
// 		contrast_slider = new ContrastSlider();
// 		flash.Lib.current.stage.addChild(contrast_slider);

		// The time indicator
		time_indicator = new TimeIndicator();
		flash.Lib.current.stage.addChild(time_indicator);

	}

	static private function togglePlay(e:Event):Void {
		if (play_button.getValue() == 1) {
			play_button.setValue(0);
			stopSound();
		} else {
			play_button.setValue(1);
			playSound();
		}
		play_button.redraw();
	}

	static private function mainMouseUp(e:Event):Void {
// 		if (progress_bar.mouse_down) {
// 			sound_position = progress_bar.position;
//  			playSound();
// 		}
// 		if (zoomer.slider_active) {
// 			sound_position = zoomer.getSoundPosition();
//  			playSound();
// 		}
	}

	static private function mainMouseDown(e:Event):Void {
// 		if (e.target == progress_bar.well) {
// 			stopSound();
// 		}
// 		if (e.target == zoomer.fft) {
// 			stopSound();
// 		}
	}

	static function playSound():Void {
		sound_player.play(sound_position * sound_player.length());
		sound_state = 1;
		play_button.setValue(1);
	}

	static function stopSound():Void {
		sound_player.stop();
		sound_state = 0;
	}

	// The main coordinating function that looks at the status of all the
	// objects and updates the other objects based on the current state.
	static function onTimer() {
		// Current position in the song
		if (sound_state == 1) {
			sound_position = sound_player.getPosition();
		}
		sound_loaded = sound_player.getLoaded();

// 		// play/pause button
// 		if (sound_state == 0 && play_button.getValue() == 1) {
// 			playSound();
// 		}
// 		if (sound_state == 1 && play_button.getValue() == 0) {
// 			stopSound();
// 		}

		// Volume
		if (sound_state == 1) {
			sound_player.setVolume(volume_slider.getValue());
		}

		// Time indicator
		time_indicator.value = sound_position * sound_player.length();
		if (progress_bar.mouse_down) {
			time_indicator.value = progress_bar.position * sound_player.length();
		}
// 		if (zoomer.slider_active) {
// 			time_indicator.value = zoomer.getSoundPosition() * sound_player.length();
// 		}
		time_indicator.redraw();

// 		// Progress bar
		if (!progress_bar.mouse_down) {
			progress_bar.position = sound_position;
		}
// 		if (zoomer.slider_active) {
// 			progress_bar.position = zoomer.getSoundPosition();
// 		}
 		progress_bar.loaded = sound_loaded;
		progress_bar.redraw();
// 		progress_bar.setContrast(contrast_slider.getValue());
// 		progress_bar.setBrightness(brightness_slider.getValue());

// 		// Zoomed progress bar
// 		if (!zoomer.slider_active) {
// 			zoomer.setSoundPosition(sound_position);
// 		}
// 		if (progress_bar.mouse_down) {
// 			zoomer.setSoundPosition(progress_bar.position);
// 		}
// 		zoomer.redraw();
// 		zoomer.setContrast(contrast_slider.getValue());
// 		zoomer.setBrightness(brightness_slider.getValue());

		if (sound_position > 0.99) {
			play_button.setValue(0);
			stopSound();
			sound_position = 0.0;
		}

		
	}

}


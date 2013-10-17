import flash.display.Sprite;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;

class SoundPlayer extends Sprite {
	private var url:String;
	var s:Sound;
	var sc:SoundChannel;
	var st:SoundTransform;

	var playing : Bool;
	
	public function new() {
		super();

		var request:URLRequest = new URLRequest(SimplePlay.song_url);

// 		url = "src/library/a.mp3";
// 		var request:URLRequest = new URLRequest(url);

		s = new Sound();
		s.load(request);

		st = new SoundTransform();
		
		playing = false;
	}

	public function getLoaded():Float {
		return s.bytesLoaded / s.bytesTotal;
	}

	// The length of the sound file
	public function length():Float {
		return s.length;
	}

	// The position that we are playing in the sound file
	public function getPosition():Float {
		return sc.position / s.length;
	}

	//
	// Transport controls
	//
	public function play(position:Float):Void {
		sc = s.play(position);
		playing = true;
	}

	public function stop():Void {
		if (playing == true) {
			sc.stop();
		}
		playing = false;
	}

	//
	// Volume
	//
	public function getVolume():Float {
		return sc.soundTransform.volume;
	}

	public function setVolume(v:Float):Void {
		st.volume = v;
		sc.soundTransform = st;
	}

}

import flash.display.Loader;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;


class PlayButton extends Sprite {

	private var loader1:Loader;
	private var loader2:Loader;

	public var state:Int;

	public function new() {
		super();

		state = 0;

		// Play High
		loader1 = new Loader();
		loader1.visible = false;
		loader1.contentLoaderInfo.addEventListener(Event.INIT, initListener);
		loader1.load(new URLRequest("/src/library/play.png"));

		// Play Muted
		loader2 = new Loader();
		loader2.visible = false;
		loader2.contentLoaderInfo.addEventListener(Event.INIT, initListener);
		loader2.load(new URLRequest("/src/library/pause.png"));

		this.x = 0;
		this.y = 20;

	}

	private function initListener (e:Event):Void {
		addChild(loader1.content);
		addChild(loader2.content);
		redraw();
	}

	public function redraw ():Void {
		if (state == 1) {
			loader1.content.visible = true;
			loader2.content.visible = false;
		} else {
			loader1.content.visible = false;
			loader2.content.visible = true;
		}
	}

	public function getValue():Int {
		return state;
	}

	public function setValue(n:Int):Void {
		state = n;
		redraw();
	}

}
import flash.display.Sprite;
import flash.display.Shape;
import flash.events.MouseEvent;
import flash.geom.Point;

class VolumeSlider extends Sprite {

	static var well:Sprite;
	static var selector:Sprite;

	static var selector_height : Int = 20;
	static var selector_width  : Int = 100; 

	static var down : Bool;

	static var point : Point;
	static var local_point : Point;

 	public var _value : Float;
	public var _mute : Bool;

	public var volume_button:VolumeButton;

	public function new () {
		super();

 		_value = 0.8;	
		_mute = false;

 		flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
 		flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
 		flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, mouseReleased);

		point = new Point();
		local_point = new Point();
		
		well = new Sprite();
		well.graphics.beginFill(0xEEEEEE,1);
		well.graphics.drawRect(0,0,selector_width,selector_height);
		this.addChild(well);

		selector = new Sprite();
		this.addChild(selector);

		this.x = 45;
		this.y = 22;

		down = false;

		// Volume Button
		volume_button = new VolumeButton();
// 		volume_button.x = 147;
 		volume_button.x = 102;
 		volume_button.y = -1;
		this.addChild(volume_button);

		redraw();
	}

 	function redraw () {

 		selector.graphics.clear();

		// Full selector
 		selector.graphics.beginFill(0xAAAAAA,1);
 		selector.graphics.moveTo(0,selector_height);
 		selector.graphics.lineTo(selector_width,0);
 		selector.graphics.lineTo(selector_width,selector_height);
 		selector.graphics.lineTo(0,selector_height);

		// Value
		selector.graphics.beginFill(0x777777,1);
		selector.graphics.moveTo(0,selector_height);
 		selector.graphics.lineTo(_value * selector_width,selector_height - (_value * selector_height));
 		selector.graphics.lineTo(_value * selector_width,selector_height);

 	}

 	function mouseDown (e:MouseEvent):Void {
		if (e.target == well || e.target == selector) {
			down = true;
			_value = e.localX / selector_width;
			redraw();
		}
 	}


 	function mouseReleased (e:MouseEvent):Void {
		down = false;
 	}

 	function mouseMove (e:MouseEvent):Void {
		if (down == true) {
			if (e.target == well || e.target == selector) {
				_value = e.localX / selector_width;
			}
			if (e.target == this.stage) {
				point.x = e.localX;
				point.y = e.localY;
				local_point = well.globalToLocal(point);
				if (local_point.x > selector_width) {
					_value = 1.0;
				} else if (local_point.x < 0) {
					_value = 0.0;
				} else {
					_value = local_point.x / selector_width;
				}
			}
			redraw();
		}
	}

	public function getValue():Float {
		if (volume_button.toggle_state == 0) {
			return 0.0;
		} else {
			return _value;
		}
	}
}

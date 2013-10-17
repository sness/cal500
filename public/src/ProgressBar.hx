import flash.display.Loader;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.Bitmap;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.filters.ColorMatrixFilter;
import flash.geom.Point;


class ProgressBar extends Sprite {

// 	// constant for contrast calculations:
// 	private static var DELTA_INDEX:Array<Float> = [
// 		0,    0.01, 0.02, 0.04, 0.05, 0.06, 0.07, 0.08, 0.1,  0.11,
// 		0.12, 0.14, 0.15, 0.16, 0.17, 0.18, 0.20, 0.21, 0.22, 0.24,
// 		0.25, 0.27, 0.28, 0.30, 0.32, 0.34, 0.36, 0.38, 0.40, 0.42,
// 		0.44, 0.46, 0.48, 0.5,  0.53, 0.56, 0.59, 0.62, 0.65, 0.68, 
// 		0.71, 0.74, 0.77, 0.80, 0.83, 0.86, 0.89, 0.92, 0.95, 0.98,
// 		1.0,  1.06, 1.12, 1.18, 1.24, 1.30, 1.36, 1.42, 1.48, 1.54,
// 		1.60, 1.66, 1.72, 1.78, 1.84, 1.90, 1.96, 2.0,  2.12, 2.25, 
// 		2.37, 2.50, 2.62, 2.75, 2.87, 3.0,  3.2,  3.4,  3.6,  3.8,
// 		4.0,  4.3,  4.7,  4.9,  5.0,  5.5,  6.0,  6.5,  6.8,  7.0,
// 		7.3,  7.5,  7.8,  8.0,  8.4,  8.7,  9.0,  9.4,  9.6,  9.8, 
// 		10.0
// 	];

	// sness - read these from the external flash object HTML
	static var globalWidth:Int = 500;
	static var globalHeight:Int = 300;

	public var well : Sprite;     // A holder for everything
 	private var slider : Loader;  // The slider indicator
// 	public var fft : Loader;     // The fft picture
	var loaded_background : Shape; // The background of the loaded bar
	var loaded_indicator : Shape;  // The progress indicator of the loaded bar

	public var position : Float;  // Position that we are at in the sound file
	public var loaded : Float;    // Amount of the sound file that is loaded
	private var ready : Int;      // Have all the Loaders finished loading?

	public var mouse_down : Bool; // Is the mouse currently down?
	static var point : Point;
	static var local_point : Point;

	static var selector_height : Int = 20;
	static var selector_width  : Int = 500; 

// 	var currentContrast : Int;    // The current contrast of the fft picture [0..100]
// 	var currentBrightness : Int;  // The current brightness of the fft picture [0..100]

	public function new() {
		super();

		position = 0;
		loaded = 0;
		ready = 0;

		this.y = 0;

// 		currentContrast = 50;
// 		currentBrightness = 50;

		// Register mouse events with the main ancestor stage
//  		flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
//  		flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
//  		flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);

		// Well to hold everything
		well = new Sprite();

// 		// Slider
 		slider = new Loader();
 		slider.visible = false;
 		slider.contentLoaderInfo.addEventListener(Event.INIT, initListener);
 		slider.load(new URLRequest("/src/library/slider.png"));

// 		// FFT
// 		fft = new Loader();
// 		fft.visible = false;
// 		fft.contentLoaderInfo.addEventListener(Event.INIT, initListener);
// 		fft.load(new URLRequest("src/library/fft.png"));

		// The background of the loaded bar
		loaded_background = new Shape();
		loaded_background.graphics.lineStyle(0);
		loaded_background.graphics.beginFill(0xAAFFAA,1);
		loaded_background.graphics.drawRect(0,0,globalWidth,20);
		loaded_background.x = 0;
		loaded_background.y = 0;
		well.addChild(loaded_background);

		// The indicator of the loaded bar
		loaded_indicator = new Shape();
		loaded_indicator.graphics.lineStyle(0);
		loaded_indicator.graphics.beginFill(0xAAAAAA,1);
		loaded_indicator.graphics.drawRect(0,0,1,20);
		loaded_indicator.x = 0;
		loaded_indicator.y = 0;
		well.addChild(loaded_indicator);

		addChild(well);
	}

	private function initListener (e:Event):Void {
// 		well.addChild(fft.content);
 		well.addChild(slider.content);
		//		slider.content.x = -8;
		slider.content.x = 0;
		ready = 1;
		redraw();
 	}

 	function mouseDown (e:MouseEvent):Void {
// 		trace("target=" + e.target);
		if (e.target == well) {
			mouse_down = true;
			position = e.localX / selector_width;
			redraw();
// 			trace('down');
		}
 	}

 	function mouseUp (e:MouseEvent):Void {
		mouse_down = false;
// 		trace('up');
 	}

 	function mouseMove (e:MouseEvent):Void {
		if (mouse_down == true) {
			if (e.target == well) {
				position = e.localX / selector_width;
			}
			if (e.target == this.stage) {
				point.x = e.localX;
				point.y = e.localY;
				local_point = well.globalToLocal(point);
				if (local_point.x > selector_width) {
					position = 1.0;
				} else if (local_point.x < 0) {
					position = 0.0;
				} else {
					position = local_point.x / selector_width;
				}
			}
			redraw();
// 			trace('move');
		}
	}

	public function redraw():Void {
		if (ready == 1) {
			slider.content.x = position * globalWidth - 8;
		}
 		loaded_indicator.width = loaded * globalWidth;
	}

// 	public function setContrast(n:Float):Void {
// 		if (currentContrast != Std.int(n * 100)) {
// 			currentContrast = Std.int(n * 100);
//  			adjustImage();
// 		}
// 	}

// 	public function setBrightness(n:Float):Void {
		
// 		if (currentBrightness != Std.int(n * 100)) {
// 			currentBrightness = Std.int(n * 100);
//  			adjustImage();

// 		}
// 	}

//   	public function adjustImage():Void {

// 		if (ready == 1) {
//   		// Generate Contrast Adjustment
//     		var x:Float;
//     		if (currentContrast<0) {
//     			x = 127+currentContrast/100*127;
//   		} else {
//     			x = currentContrast%1;
//     			if (x == 0) {
//     				x = DELTA_INDEX[currentContrast];
//     			} else {
//     				//x = DELTA_INDEX[(currentContrast<<0)]; // this is how the IDE does it.
//     				x = DELTA_INDEX[(currentContrast<<0)]*(1-x)+DELTA_INDEX[(currentContrast<<0)+1]*x; // use linear interpolation for more granularity.
//     			}
//     			x = x*127+127;
//     		}
//    		var a : Array<Float> = [ 
//   			x/127,0,0,0,0.5*(127-x) + currentBrightness,
//   			0,x/127,0,0,0.5*(127-x) + currentBrightness,
//   			0,0,x/127,0,0.5*(127-x) + currentBrightness,
//   			0,0,0,1,0,
//   			0,0,0,0,1
//   		];
//    		var colorMat:ColorMatrixFilter = new ColorMatrixFilter(a);
// 		fft.content.filters = [colorMat];

// 		//trace("contrast=(" + currentContrast + ") brightness=(" + currentBrightness + ")");
//   	}
// 	}

}
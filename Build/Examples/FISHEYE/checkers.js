function Checkers(canvas, settings) {
	
	// canvas objects
	var canvas, context, width, height;
	
	// settings
	var firstColor, secondColor, minCount, draw;
	
	
	// validate passed data
	function validate(c) {

		if (!c)
			throw 'Canvas element was not found';
			
		if (!c.getContext('2d'))
			throw 'Canvas 2D is not supported by browser';
	}
	
	// init canvas objects
	function initCanvas(c) {
		canvas = c;
		context = c.getContext('2d');
		
		width = canvas.width;
		height = canvas.height;
	}

	function isColor(val) {
		return 	/(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)/i.test(val);
	}
	
	function isPositive(val) {
		return val > 0;
	}
	
	function initSettings(s) {
		
		// defaults
		var firstColorDef = 'black';
		var secondColorDef = 'white';
		var minCountDef = 10;
		
		// init settings
		firstColor = isColor(s.firstColor) ? s.firstColor : firstColorDef;
		secondColor = isColor(s.secondColor) ? s.secondColor : secondColorDef;
		minCount = isPositive(s.minCount) ? s.minCount : minCountDef;
		draw = s.draw !== undefined ? s.draw : false;
	}
	

	// draw checkers
	this.draw = function() {
		
		var step = Math.min(width, height) / minCount;
		var w = width / step, wf = Math.floor(w);
		var h = height / step, hf = Math.floor(h);
		var stepX = w === wf ? step : width / wf;
		var stepY = h === hf ? step : height / hf;
		
		for (var y = 0; y < hf; y++) {
			for (var x = 0; x < wf; x++) {
				context.fillStyle = (y + x) % 2 === 0 ? firstColor : secondColor;
				context.fillRect(x * stepX, y * stepY, stepX, stepY);
			}
		}
	};
	
	
	validate(canvas);
	
	//init
	initCanvas(canvas);
	initSettings(settings || {});
	
	if (draw)
		this.draw();
}
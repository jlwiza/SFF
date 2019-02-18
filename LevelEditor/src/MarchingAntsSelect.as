/*******************************************************************************
 ACTIONSCRIPT 3 MARCHING ANTS SELECTION MARQUEE
 ********************************************************************************
 Generate a classic marching ants marquee using ActionScript 3, the Drawing API and matrix transforms.
 
 This class is an AS3 Port of this AS2 Example; http://www.nocircleno.com/experiments/selection_ants_proof/index.html
 with some additional methods added in.
 
 You have the ability to either set a fixed marquee with the option to allow it to be draggable. Or you can let the user click and
 drag to create the marquee. At the moment the class does not support constrained rectangle dragging.
 
 You may also define the colour of the marquee's marching ants.
 *******************************************************************************
 SAMPLE USEAGE
 ********************************************************************************
 Set up for user defined drag n draw marquee
 var thumb:MarchingAntsSelect = new MarchingAntsSelect(true)
 addChild(thumb)
 
 Set up for fixed author defined marque box, with the selection box set to draggable.
 Creates a selection box at 100x, 100 y, that is 300 px by 300 px and is draggable.
 var thumb:MarchingAntsSelect = new MarchingAntsSelect(false, 100, 100, 300, 300, true)
 addChild(thumb)
 ********************************************************************************
 PUBLIC METHOD
 ********************************************************************************
 setAntsColour: Use for programtically setting the colour of the marching ants. You need to pass
 two params, both AARRGGBB uints, representing the two colours of the marching ants. If your two
 colours are two close to each other, the marching ants line will appear solid.
 Example
 setAntsColour(0x00FF00FF,0x00FFFFFF)
 ********************************************************************************
 @langversion ActionScript 3.0
 @Flash Player 9.0.28.0
 
 @author noponies
 @Version 1.0 Released 25.03.2008
 
 ********************************************************************************/
package {
	
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class MarchingAntsSelect extends Sprite {
		//--------------------------------------
		// PRIVATE INSTANCE PROPERTIES
		//--------------------------------------
		private var userDrawSelect:Boolean;
		private var draggable:Boolean;
		private var selectionSprite:Shape;
		private var lineThickness:int=1;
		private var horz_bmp:BitmapData;
		private var vert_bmp:BitmapData;
		private var antsColor:uint = 0xFF000000;//black AARRGGBB
		private var antsOffColor:uint = 0xFFFFFFFF;//white AARRGGBB
		private var antsTimer:Timer=new Timer(80,0);//timer
		private var bitmapShift:int=0;//internal var for animating bitmaps
		private var point1:Object = new Object();
		private var point2:Object = new Object();
		//--------------------------------------
		// GETTERS/SETTERS
		//--------------------------------------
		public function set antsLineWeight(newLineWeight:int):void {
			lineThickness = newLineWeight;
		}
		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		/**
		 *@ userDrawSelect: Boolean, whether or not you want user to be able to draw the slection marquee themselves
		 *@antsBoxX: Int, x pos of box if programatically placed. Ignored if the user is drawing the box
		 *@antsBoxY: Int, y pos of box if programatically placed. Ignored if the user is drawing the box
		 *@antsBoxWidth: Int, width pos of box if programatically placed. Ignored if the user is drawing the box
		 *@antsBoxHeight: Int, height pos of box if programatically placed. Ignored if the user is drawing the box
		 *@draggable: Boolean, if programtically placed, can the user move the box
		 */
		public function MarchingAntsSelect(userDrawSelect:Boolean, antsBoxX:int = 100, antsBoxY:int = 100, antsBoxWidth:int = 200, antsBoxHeight:int = 200, draggable:Boolean = false) {
			//do we want to let the user draw the selection marquee?
			this.userDrawSelect = userDrawSelect;
			this.draggable = draggable;
			//set defaults
			point1.x = antsBoxX;
			point1.y = antsBoxY;
			point2.x = antsBoxX+antsBoxWidth;
			point2.y = antsBoxY+antsBoxHeight;
			
			//create the marching ants bitmaps
			createBitMapMarquee();
			//empty sprite that we draw into
			selectionSprite=new Shape();
			addChild(selectionSprite);
			
			//create the timer event that animates the marquee
			antsTimer.addEventListener(TimerEvent.TIMER,antsTimerListener);
			//get stage access
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		//--------------------------------------
		// PUBLIC INSTANCE METHODS
		//--------------------------------------
		//Set new colours for marching ants
		public function setAntsColour(newAntsCol:uint,newAntsOffCol:uint ):void {
			antsColor = newAntsCol;
			antsOffColor = newAntsOffCol;
			createBitMapMarquee();
		}
		//--------------------------------------
		// PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		
		private function addedToStage(event:Event):void {
			//init the event listeners etc
			setUpMarquee();
		}
		//generate the bitmaps for the marquee
		private function createBitMapMarquee():void {
			vert_bmp = new BitmapData(2,4,false, antsColor);
			vert_bmp.fillRect(new Rectangle(0,0,2,2), antsOffColor);
			horz_bmp = new BitmapData(4,2,false, antsColor);
			horz_bmp.fillRect(new Rectangle(0,0,2,2), antsOffColor);
		}
		//init the listeners etc
		private function setUpMarquee():void {
			//check to see if we are letting the user draw the select box
			if (userDrawSelect) {
				stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			} else {
				//we are just drawing a static shape, so, lets draw it and as we are adding in a new sprite to this shape to
				//allow us to drag it around, if required we have to make it slightly smaller than the animated marquee, otherwise it will cover it up.
				var bg = drawShape((point2.x - point1.x)-lineThickness*2, (point2.y-point1.y)-lineThickness*2, 0xFFFF00,0);
				selectionSprite.addChild(bg);
				antsTimer.start();
				
				if (draggable) {
					selectionSprite.buttonMode = true;
					selectionSprite.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
					selectionSprite.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
					
				}
			}
		}
		//mousedown
		//turn off the timer, add the mouseMove event listener and store the starting points of our marquee rectangle
		private function mouseDownHandler(event:MouseEvent):void {
			if (userDrawSelect) {
				antsTimer.stop();
				stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
				// store point 1
				point1.x=stage.mouseX;
				point1.y=stage.mouseY;
			} else {
				selectionSprite.startDrag();
			}
			
		}
		//mouse up handler
		//remove the mouseMove event listener from the stage, store the end points of the marquee rectangle, start the timer
		private function mouseUpHandler(event:MouseEvent):void {
			if (userDrawSelect) {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
				// store point 2
				point2.x = stage.mouseX;
				point2.y = stage.mouseY;
				antsTimer.start();
			} else {
				selectionSprite.stopDrag();
			}
			
		}
		//draw the marquee when the user is moving their mouse. If you want to createa constrained rectangle, simply
		//set your your width to equal the height of the new rectangle the user has drawn.
		private function mouseMoveHandler(event:MouseEvent):void {
			bitmapShift == 3?bitmapShift=0:bitmapShift++;
			drawSelectionRectangle(point1.x, point1.y, selectionSprite.mouseX, selectionSprite.mouseY, bitmapShift);
			// update after event
			event.updateAfterEvent();
		}
		
		
		// use this to adjust shift of animation of dashes
		private function antsTimerListener(event:TimerEvent):void {
			// if the bitmapShift value is 3 then we reset to zero, else add one to...
			// 3 is used because it is the length of the bitmap if you count 0 as one.
			bitmapShift == 3?bitmapShift=0:bitmapShift++;
			drawSelectionRectangle(point1.x,point1.y,point2.x,point2.y,bitmapShift);
			
		}
		//utility function for drawing a shape
		private function drawShape(w:Number, h:Number, col:int, trans:Number):Shape {
			var s:Shape = new Shape;
			s.graphics.beginFill(col,trans);
			s.graphics.drawRect(0, 0, w, h);
			s.graphics.endFill();
			s.x = point1.x+lineThickness;
			s.y = point1.y+lineThickness;
			return s;
		}
		//the marquee drawing function
		private function drawSelectionRectangle(x1:int,y1:int,x2:int,y2:int,textureOffset:Number):void {
			
			selectionSprite.graphics.clear();
			
			// draw horzontial lines
			selectionSprite.graphics.beginBitmapFill(horz_bmp,new Matrix(1,0,0,1,textureOffset,0));
			
			// draw top line
			selectionSprite.graphics.moveTo(x1,y1);
			selectionSprite.graphics.lineTo(x2,y1);
			selectionSprite.graphics.lineTo(x2,y1 + lineThickness);
			selectionSprite.graphics.lineTo(x1,y1 + lineThickness);
			selectionSprite.graphics.lineTo(x1,y1);
			
			// draw bottom line
			selectionSprite.graphics.moveTo(x1,y2 - lineThickness);
			selectionSprite.graphics.lineTo(x2,y2 - lineThickness);
			selectionSprite.graphics.lineTo(x2,y2);
			selectionSprite.graphics.lineTo(x1,y2);
			selectionSprite.graphics.lineTo(x1,y2 - lineThickness);
			selectionSprite.graphics.endFill();
			
			// draw vertical lines
			selectionSprite.graphics.beginBitmapFill(vert_bmp,new Matrix(1,0,0,1,0,textureOffset));
			
			// draw left line
			selectionSprite.graphics.moveTo(x1,y1 + lineThickness);
			selectionSprite.graphics.lineTo(x1 + lineThickness,y1 + lineThickness);
			selectionSprite.graphics.lineTo(x1 + lineThickness,y2 - lineThickness);
			selectionSprite.graphics.lineTo(x1,y2 - lineThickness);
			selectionSprite.graphics.lineTo(x1,y1 + lineThickness);
			
			// draw right line
			selectionSprite.graphics.moveTo(x2 - lineThickness,y1 + lineThickness);
			selectionSprite.graphics.lineTo(x2,y1 + lineThickness);
			selectionSprite.graphics.lineTo(x2,y2 - lineThickness);
			selectionSprite.graphics.lineTo(x2 - lineThickness,y2 - lineThickness);
			selectionSprite.graphics.lineTo(x2 - lineThickness,y1 + lineThickness);
			
			selectionSprite.graphics.endFill();
		}
		
	}
}
import flash.display.NSprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Matrix;
import flash.geom.Rectangle;


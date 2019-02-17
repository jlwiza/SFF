package com.jonLwiza.engine.actors
{
	
	import com.jonLwiza.engine.GeneralElements.Director;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.baseConstructs.GeneralMotor;
	
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	
	import starling.display.Image;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	// this may fuck up some shit, maybe i dunno
	public class Scenary extends GeneralMotor
	{
		// hmm im thinking this might just be lazy but it may be pretty genius too what we could do is make scenary more like miscelanious things in here
		// the advantage being that we could have special abilities that could be invoked but nothing necessarily is and we have a final class something like scenary resources
		// that we can add certain functions, so we can add to it and put more, making scenary potentially the most powerful class since i could make anything i want
		// the best part of it is that you can make things really quickly and just add more and more shit to it, without making a new class entirely and its very lightweight

		private var _imge:Image;
		public var frms:int;
		
		
		/**right now only takes image for testing purpose but i will make it smarter to take an image or an animation that will automatically loop
		 * */
		public function Scenary(img:Image = null)
		{
			super();
			imge = img
				// it should be smarter than this, maybe but i cant see a reason why so its fine
			drctrList = Director.scenary
		}
		protected override function createGeom():ObjectContainer3D
		{
			// try changing width and height once this works
			
			
			var awyObj:ObjectContainer3D = new ObjectContainer3D()
			if(true){
				awyObj = new Mesh(new PlaneGeometry(2048*2,2048*2),new ColorMaterial())
				obj2 = new Mesh(new CubeGeometry(40,900,900),new ColorMaterial(Color.LIME))
					awyObj.rotationX = -90
					LevelEditor.away3dView.scene.addChild(obj2)
				LevelEditor.away3dView.scene.addChild(awyObj)
			}
			return awyObj;
		}
		
		
		override protected function createArtAsset():void
		{
			if(imge == null){
			imge = new Image(Assets.getTexture("Default"));
			
			}
			imge.x = 0;
			imge.y = 0;
			addChild(imge);
			imge.alignPivot("center","center")
			width = imge.width
			height = imge.height
		}
		public function  Update():void
		{
			if(updateZdepth){
			MainSceneMotor.UpdateZDepth(this);
			}
		}

		public function refreshImage():void{
			removeChildren();
			createArtAsset()
		}
		public function get imge():Image
		{
			return _imge;
		}

		public function set imge(value:Image):void
		{
			_imge = value;
		}

		override public function get width():Number{
			return imge.width
		}
		
	}
}

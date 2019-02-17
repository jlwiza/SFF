package com.jonLwiza.engine.GeneralElements
{
	import com.jonLwiza.engine.Main;
	import com.jonLwiza.engine.Scenes.GeneralSceneAssets.MainSceneMotor;
	import com.jonLwiza.engine.baseConstructs.GeneralActor;
	import com.jonLwiza.engine.helperTypes.TMXParser;
	import com.jonLwiza.engine.helperTypes.Vector3;
	
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import away3d.events.MouseEvent3D;
	
	import nape.dynamics.InteractionFilter;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Polygon;
	
// this should inheret from Path
	public class Ground extends Path
	{
		//okay at first i put this just as ints because i didnt wanna waste a teeny bit of memory instead what im gonna do is put them as numbers and then go back and change em.. or not
		
		
		//private var main:Main = new Main();
		private var _slope:Number;
		public var pts:TMXParser = new TMXParser();
		public static var ptsArray:Array = new Array;
		public var p1:Object = new Object();
		public var p2:Object = new Object();
		private var actrX:Number;
		private var i:int;
		private var vect2:Array = [[]];
		private var lastVect:Array;

		private var dpTrv:Number;

		private var currAngle:Number;
		private var p0:Object = new Object();
		private var p3:Object = new Object();
		public function Ground()
		{
			
		ptsArray = [{X:0,Y:789.1500244140625,Z:-2,D:0},{X:-42.349998474121094,Y:789.1500244140625,Z:-2,D:42.397197675766954},{X:16.22369956970215,Y:814.3063354492188,Z:-1.6704620122909546,D:100.97182270926012},{X:76.81300354003906,Y:834.4328002929688,Z:-1.1863360404968262,D:161.56306080163162},{X:137.93899536132813,Y:852.7179565429688,Z:-0.6606899499893188,D:222.69131269835088},{X:199.4759979248047,Y:869.8192138671875,Z:-0.11368000507354736,D:284.2307464329666},{X:261.2559814453125,Y:885.9612426757813,Z:0.44534993171691895,D:346.0132591551313},{X:323.239990234375,Y:901.2620239257813,Z:1.0117199420928955,D:407.99985545264735},{X:385.4280090332031,Y:915.7810668945313,Z:1.5827000141143799,D:470.19049542656984},{X:447.77398681640625,Y:929.5291137695313,Z:2.1558499336242676,D:532.5391076530973},{X:510.3059997558594,Y:942.5040283203125,Z:2.72983980178833,D:595.0737549026716},{X:572.9500122070313,Y:954.6640625,Z:3.3025596141815186,D:657.7203853305413},{X:635.7960205078125,Y:965.9739990234375,Z:3.873469829559326,D:720.568986729585},{X:698.8040161132813,Y:976.35302734375,Z:4.440790176391602,D:783.5795363430799},{X:761.9420166015625,Y:985.6961059570313,Z:5.002699851989746,D:846.720037197458},{X:825.2320556640625,Y:993.8709716796875,Z:5.55757999420166,D:910.0125086020809},{X:888.7900390625,Y:1000.7060546875,Z:6.10420036315918,D:973.5728425180054},{X:952.3790283203125,Y:1005.9200439453125,Z:6.637619972229004,D:1037.1640690458019},{X:1016.1199951171875,Y:1009.1680908203125,Z:7.154990196228027,D:1100.9071354934479},{X:1079.9600830078125,Y:1009.9080200195313,Z:7.650119781494141,D:1164.749143412912},{X:1143.780029296875,Y:1007.2860107421875,Z:8.113100051879883,D:1228.5707690195163},{X:1207.2100830078125,Y:999.8429565429688,Z:8.526000022888184,D:1292.002166609026},{X:1269.2000732421875,Y:984.7930908203125,Z:8.851799964904785,D:1353.9930129886338},{X:1326,Y:956.25,Z:9,D:1410.7931330848385},{X:1337.780029296875,Y:921.7091064453125,Z:9.5378999710083,D:1422.5854367874254},{X:1343.080078125,Y:885.4678955078125,Z:10.02750015258789,D:1427.9080513628303},{X:1341.1300048828125,Y:849.0032958984375,Z:10.442999839782715,D:1429.9018983077974},{X:1331,Y:813.88623046875,Z:10.75570011138916,D:1440.0367283698},{X:1312.77001953125,Y:782.2102661132813,Z:10.94159984588623,D:1458.2676566676757},{X:1287.9500732421875,Y:755.3500366210938,Z:11,D:1483.0876716630369},{X:1242.3599853515625,Y:737.722412109375,Z:97.03900146484375,D:1580.4589502155047},{X:1196.780029296875,Y:726.5319213867188,Z:184.29800415039063,D:1678.9052093807138},{X:1151.550048828125,Y:722.857421875,Z:272.2969970703125,D:1777.8474849161187},{X:1107.260009765625,Y:729.8763427734375,Z:360.49700927734375,D:1876.5432280536938},{X:1065.6800537109375,Y:754.4774169921875,Z:446.76300048828125,D:1972.3070729280266},{X:1033.3599853515625,Y:810.023193359375,Z:520.7659912109375,D:2053.0599642363395},{X:1024.010009765625,Y:900.2940673828125,Z:556.375,D:2089.8760415721604},{X:1036.3900146484375,Y:940.9119873046875,Z:489.81201171875,D:2157.580516533778},{X:1056.0999755859375,Y:956.3280029296875,Z:393.9469909667969,D:2255.450761061572},{X:1081.9100341796875,Y:970.3250122070313,Z:299.3179931640625,D:2353.536470264099},{X:1115.6700439453125,Y:982.3240356445313,Z:207.02499389648438,D:2451.8102509646515},{X:1161.3800048828125,Y:991.0260009765625,Z:119.7330093383789,D:2550.34598609156},{X:1226.9100341796875,Y:993.1520385742188,Z:46.237098693847656,D:2648.8134102536565},{X:1318,Y:982.0999755859375,Z:14,D:2745.439557881214},{X:1409.030029296875,Y:974.4720458984375,Z:14,D:2836.469587178089},{X:1499.8499755859375,Y:964.4959716796875,Z:14,D:2927.2895334671516},{X:1590.320068359375,Y:952.0730590820313,Z:14,D:3017.759626240589},{X:1680.320068359375,Y:936.5469970703125,Z:14,D:3107.759626240589},{X:1769.449951171875,Y:916.5841064453125,Z:14,D:3196.889509053089},{X:1856.5999755859375,Y:889.1103515625,Z:14,D:3284.0395334671516},{X:1935.550048828125,Y:844.1500244140625,Z:14,D:3362.989606709339},{X:1977.5999755859375,Y:844.2653198242188,Z:14,D:3405.0395334671516},{X:2019.699951171875,Y:844.3564453125,Z:14,D:3447.139509053089},{X:2061.7998046875,Y:844.4302978515625,Z:14,D:3489.239362568714},{X:2103.85986328125,Y:844.4891357421875,Z:14,D:3531.299421162464},{X:2145.9599609375,Y:844.5343627929688,Z:14,D:3573.399518818714},{X:2188.02978515625,Y:844.56689453125,Z:14,D:3615.469343037464},{X:2230.08984375,Y:844.5872192382813,Z:14,D:3657.529401631214},{X:2272.199951171875,Y:844.5958251953125,Z:14,D:3699.639509053089},{X:2314.27001953125,Y:844.5928955078125,Z:14,D:3741.709577412464},{X:2356.33984375,Y:844.5787353515625,Z:14,D:3783.779401631214},{X:2398.4599609375,Y:844.5534057617188,Z:14,D:3825.899518818714},{X:2440.52978515625,Y:844.5172119140625,Z:14,D:3867.969343037464},{X:2482.60986328125,Y:844.4699096679688,Z:14,D:3910.049421162464},{X:2524.68994140625,Y:844.4118041992188,Z:14,D:3952.129499287464},{X:2566.77001953125,Y:844.3428955078125,Z:14,D:3994.209577412464},{X:2608.849853515625,Y:844.2630004882813,Z:14,D:4036.289411396839},{X:2650.929931640625,Y:844.1722412109375,Z:14,D:4078.369489521839},{X:2693.02001953125,Y:844.0704956054688,Z:14,D:4120.459577412465},{X:2735.06982421875,Y:843.9578247070313,Z:14,D:4162.509382099965},{X:2777.14990234375,Y:843.8338623046875,Z:14,D:4204.589460224965},{X:2819.239990234375,Y:843.6988525390625,Z:14,D:4246.67954811559},{X:2861.33984375,Y:843.5524291992188,Z:14,D:4288.779401631215},{X:2903.429931640625,Y:843.3946533203125,Z:14,D:4330.86948952184},{X:2945.52978515625,Y:843.2252197265625,Z:14,D:4372.969343037465},{X:2987.579833984375,Y:843.0442504882813,Z:14,D:4415.01939186559},{X:3029.679931640625,Y:842.8511962890625,Z:14,D:4457.11948952184},{X:3071.77978515625,Y:842.6461181640625,Z:14,D:4499.219343037465},{X:3113.849853515625,Y:842.4288940429688,Z:14,D:4541.28941139684},{X:3155.949951171875,Y:842.1990966796875,Z:14,D:4583.38950905309},{X:3198.02001953125,Y:841.9569091796875,Z:14,D:4625.459577412465},{X:3240.079833984375,Y:841.7018432617188,Z:14,D:4667.51939186559},{X:3282.14990234375,Y:841.43359375,Z:14,D:4709.589460224965},{X:3324.27001953125,Y:841.15185546875,Z:14,D:4751.709577412465},{X:3366.33984375,Y:840.8566284179688,Z:14,D:4793.779401631215},{X:3408.419921875,Y:840.5474853515625,Z:14,D:4835.859479756215},{X:3450.5,Y:840.2239990234375,Z:14,D:4877.939557881215},{X:3492.57958984375,Y:839.8861083984375,Z:14,D:4920.019147724965},{X:3534.65966796875,Y:839.5333251953125,Z:14,D:4962.099225849965},{X:3576.75,Y:839.1652221679688,Z:14,D:5004.189557881215},{X:3618.82958984375,Y:838.7814331054688,Z:14,D:5046.269147724965},{X:3660.919921875,Y:838.3818359375,Z:14,D:5088.359479756215},{X:3702.969970703125,Y:837.9661254882813,Z:14,D:5130.40952858434},{X:3745.06982421875,Y:837.5330200195313,Z:14,D:5172.509382099965},{X:3787.129638671875,Y:837.0830078125,Z:14,D:5214.56919655309},{X:3829.22998046875,Y:836.61474609375,Z:14,D:5256.669538349965},{X:3871.289794921875,Y:836.1285400390625,Z:14,D:5298.72935280309},{X:3913.35009765625,Y:835.6233520507813,Z:14,D:5340.789655537465},{X:3955.460205078125,Y:835.0980224609375,Z:14,D:5382.89976295934},{X:3997.539794921875,Y:834.5531005859375,Z:14,D:5424.97935280309},{X:4039.60986328125,Y:833.9873046875,Z:14,D:5467.049421162465},{X:4081.68994140625,Y:833.39990234375,Z:14,D:5509.129499287465},{X:4123.77001953125,Y:832.7902221679688,Z:14,D:5551.209577412465},{X:4165.85009765625,Y:832.1572265625,Z:14,D:5593.289655537465},{X:4207.93994140625,Y:831.5001220703125,Z:14,D:5635.379499287465},{X:4249.98974609375,Y:830.81884765625,Z:14,D:5677.429303974965},{X:4292.08984375,Y:830.1105346679688,Z:14,D:5719.529401631215},{X:4334.14990234375,Y:829.3760986328125,Z:14,D:5761.589460224965},{X:4376.259765625,Y:828.6126098632813,Z:14,D:5803.699323506215},{X:4418.31982421875,Y:827.8201904296875,Z:14,D:5845.759382099965},{X:4460.39990234375,Y:826.9968872070313,Z:14,D:5887.839460224965},{X:4502.47998046875,Y:826.1409912109375,Z:14,D:5929.919538349965},{X:4544.56005859375,Y:825.2511596679688,Z:14,D:5971.999616474965},{X:4586.60986328125,Y:824.3263549804688,Z:14,D:6014.049421162465},{X:4628.69970703125,Y:823.3629150390625,Z:14,D:6056.139264912465},{X:4670.759765625,Y:822.3604736328125,Z:14,D:6098.199323506215},{X:4712.830078125,Y:821.3157348632813,Z:14,D:6140.269636006215},{X:4754.89990234375,Y:820.2261962890625,Z:14,D:6182.339460224965},{X:4796.97998046875,Y:819.0888061523438,Z:14,D:6224.419538349965},{X:4839.02978515625,Y:817.901611328125,Z:14,D:6266.469343037465},{X:4881.080078125,Y:816.659912109375,Z:14,D:6308.519636006215},{X:4923.14990234375,Y:815.3594970703125,Z:14,D:6350.589460224965},{X:4965.2197265625,Y:813.9959106445313,Z:14,D:6392.659284443715},{X:5007.259765625,Y:812.5651245117188,Z:14,D:6434.699323506215},{X:5049.31982421875,Y:811.0597534179688,Z:14,D:6476.759382099965},{X:5091.39013671875,Y:809.4725952148438,Z:14,D:6518.829694599965},{X:5133.4296875,Y:807.7973022460938,Z:14,D:6560.869245381215},{X:5175.47998046875,Y:806.0223999023438,Z:14,D:6602.919538349965},{X:5217.509765625,Y:804.1380004882813,Z:14,D:6644.949323506215},{X:5259.56005859375,Y:802.1282348632813,Z:14,D:6686.999616474965},{X:5301.58984375,Y:799.9776000976563,Z:14,D:6729.029401631215},{X:5343.60986328125,Y:797.664306640625,Z:14,D:6771.049421162465},{X:5385.60986328125,Y:795.1602783203125,Z:14,D:6813.049421162465},{X:5427.60009765625,Y:792.4281616210938,Z:14,D:6855.039655537465},{X:5469.60009765625,Y:789.4164428710938,Z:14,D:6897.039655537465},{X:5511.52978515625,Y:786.0576782226563,Z:14,D:6938.969343037465},{X:5553.44970703125,Y:782.2354736328125,Z:14,D:6980.889264912465},{X:5595.2998046875,Y:777.766845703125,Z:14,D:7022.739362568715},{X:5637.009765625,Y:772.2969360351563,Z:14,D:7064.449323506215},{X:5678.43994140625,Y:764.92822265625,Z:14,D:7105.879499287465}]

			// i could put a method here to override the array given what scene your on itll be nice
			
		}
		
		
		// I used point slope to find the slope which is obviously (y-y1) = m(x-x1) which goes to y =m(x - x1)+y1
		// you dont even need to think point slope you can just derive it because you know the slope because you have both points so its just a reangement
		// I used point slope to find the slope which is obviously (y-y0) = m(x-x0) which goes to y = y1+ m(x - x1), y= y1 +dy/dx(x - x1) 
		// so it goes sonics y = y1 + slope(sonics x - x1)
		public function GroundY(actorX:Number, fixDis:Boolean = false):Number
		{
			
			//var line:Shape = new Shape(); 
//			line.graphics.lineStyle(1); 
//			line.graphics.moveTo(-400, 400); 
//			//line.graphics.lineTo(40, 20); 
//			for (var l:int = 0; l < ptsArray.length; l++) 
//			{
//				line.graphics.lineTo(ptsArray[l][X],ptsArray[l][Y]); 
//			}
//			main.stage.addChild(line); 
//			
			
			// sometimes the distance is just wrong and thats why this really doesnt help to much
			//TODO:JON this needs fixing for dynamic ground
			if(false){
			var dis:Number = 0
				if(ptsArray[0].X != 0 || ptsArray[0].Z != 0){
					ptsArray.unshift({X:0.00,Y:ptsArray[0].Y,Z:0})
				}
				
			for (var i:int = 1; i < ptsArray.length; i++) 
			{
				ptsArray[i].D
				dis+=Math.sqrt((ptsArray[i].X - ptsArray[i-1].X)*(ptsArray[i].X - Director.floorpts[i-1].X)+(Director.floorpts[i].Z - Director.floorpts[i-1].Z)*(Director.floorpts[i].Z - Director.floorpts[i-1].Z))
				ptsArray[i].D = dis
			}
			}
			
// might wanna save like the percent your in here so when i change and move shit around sonic doesnt go to shit
			// this is gonna make no sense because it just doesnt work like this
			// this will actually work since we move from left to right and it just checks the first point, as long as the first poin
			// is at the farthest left you can be, and the last is the farthest right, you should be fine , eh i have my doubts with this garbage though
			
			//****** snapping to a path explained hitheire
			// i dont know why i thought snapping to path would be dificult either
			// you just look which point is closest to sonic whichever one is put sonic at that points he's closest two then
			// put em inbetween somplace i guess, if you want, use the cursors x, y quardinets to get exact as if its on a rail
			// snapping to path is a lot like this code except it has to go through all the points in the array
			// to find the closest point, i did a closest to sonic thing in the dynamicscene handler garbage, it should e similar
			
			// these first two things look like they are probably gonna cause me trouble 
			if(ptsArray[0].D >= actorX)
			{
				
				return ptsArray[0].Y;
			}else if(ptsArray[ptsArray.length -1].D < actorX)
			{
				return ptsArray[ptsArray.length - 1].Y;
			}else{
			
			for (i = 1; i < ptsArray.length; i++) 
			{
				
				
				if(ptsArray[i].D >= actorX)
				{
					
					// eh im guessing p1 is the first point and p2 is the second 
					 p1= ptsArray[i-1];
				 	 p2= ptsArray[i];
					////("the x is at :",actor.X);
					break
				}
			}

				
//			
//			}else
			//unitX = (Math.sqrt((p2[Y]-p1[Y])*(p2[Y]-p1[Y])+(p2[X]-p1[X])*(p2[X]-p1[X])))/
			//slope = (Math.atan2(p2.Y - p1.Y,p2.X - p1.X)*180)/Math.PI;
			////("the x is at :",actor.X);
			
			
			// this shit is a whole lot more simpler than you think, its basically this
			// if you think of a pure slope, centered at 0 its just a really 2x  or whatever gives you the y that is the formula
			// than its displaced so its whatever your slope which is change in y over the change in x * x, thats it thats the thning, but unfortunately
			// what you have to do to displace the damn thing 5 -
			
			// its the ending point minus the starting point  x1 refers to the previous point
			// I used point slope to find the slope which is obviously (y-y0) = m(x-x0) which goes to y = y1+ m(x - x1), y= y1 +dy/dx(x - x1) 
			// so it goes sonics y = y1 + slope(sonics x - x1)
				var v:Number =  p1.Y + (p2.Y - p1.Y)*(actorX - p1.D)/(p2.D - p1.D)
				//trace(v)
				return v
				 
		}
		}
		// whats next on the agenda i put this in see if it works try out some touching and what not theeeneneneenenen
		// we gotta sseeeee if we can work on the physics nothing fancy, then clean up the bezier code so i can prepare to use if for animation
		// basically itll just set up a bezier between two points and itll work, but also i have to fix bezier since it is kinda a mess right now so yeah
		
		public function updateGround(actorX, floorBody):void{
			//ptsArray = EditKeyHandler.bezTool.curve; 
			//actorX += ptsArray[0].X;
			
			if(ptsArray[0].D > actorX)
			{
				// the points arent live so the perspective wont change as the camera moves
				// im not sure what the effect it will have will be
				//return [[Vec2.get(ptsArray[0].X-2000,ptsArray[0].Y),Vec2.get(ptsArray[0].X,ptsArray[0].Y),Vec2.get(ptsArray[0].X,ptsArray[0].Y+200),Vec2.get(ptsArray[0].X-2000,ptsArray[0].Y+200)], ptsArray[0].X-2000]; 
			}else if(ptsArray[ptsArray.length -1].X < actorX)
			{
				//return [[Vec2.get(ptsArray[ptsArray.length - 1].X,ptsArray[ptsArray.length - 1].Y),Vec2.get(ptsArray[ptsArray.length - 1].X+2000,ptsArray[ptsArray.length - 1].Y),Vec2.get(ptsArray[ptsArray.length - 1].X+2000,ptsArray[ptsArray.length - 1].Y+200),Vec2.get(ptsArray[ptsArray.length - 1].X,ptsArray[ptsArray.length - 1].Y+200)],ptsArray[ptsArray.length - 1].X];
			}else{
				
				for (var i:int = 0; i < ptsArray.length; i++) 
				{
					////("fjjf");
					
					if(ptsArray[i].D >= actorX)
					{
						p1= ptsArray[i-1];
						p2= ptsArray[i];
						
						break
					}
					////(p1.D, " ", p2.D," hjkl;;; ", actorX);
				}
				
			}
		}
		public function GroundShape(actorX:Number, floorBody:Body, autoUpdate:Boolean = true):void
		{
			// um i just wanna keep this here incase i wanna cheat it a bit it is sonic afterall
			actrX = actorX //+5
			//ptsArray = Ground.ptsArray
			
			
			if(actrX >= p1.D && actrX <= p2.D && autoUpdate)
			{
				return;
			}
			// I should really do some testing for this buuuut Im an idiot plus the last two scenes that are heavily dependent on this are coming up so whatevs
			if(!autoUpdate ||ptsArray[0].X != 0 || ptsArray[0].Z != 0)
			{
//				var poop:String = "first:"
//				for (var i:int = 0; i < ptsArray.length; i++) 
//				{
//					poop += "{"+ptsArray[i].X.toString()+","+ptsArray[i].Y.toString()+","+ptsArray[i].Z.toString()+","+ptsArray[i].D.toString()+"},"
//				////(p1.X,"m ",p2.Y) 
//				}
//				//(poop)
//				poop = "second:"
				// just some cleanup incase i got some dirty values
				if(ptsArray[0].X != 0 || ptsArray[0].Z != 0){
					if(ptsArray[0].X != 0)
					ptsArray.unshift({X:0.00,Y:ptsArray[1].Y,Z:0.00,D:0.00})
				}
				
				var dis:Number = 0
				for (i = 1; i < ptsArray.length; i++) 
				{
					ptsArray[i].D
					dis+=Math.sqrt((ptsArray[i].X - ptsArray[i-1].X)*(ptsArray[i].X - ptsArray[i-1].X)+(ptsArray[i].Z - ptsArray[i-1].Z)*(ptsArray[i].Z - ptsArray[i-1].Z))
					ptsArray[i].D = dis
				}
				
//				for (i= 0; i < ptsArray.length; i++) 
//				{
//					poop += "{"+ptsArray[i].X.toString()+","+ptsArray[i].Y.toString()+","+ptsArray[i].Z.toString()+","+ptsArray[i].D.toString()+"},"
//					
//				}
//				//(poop)
				
			}
			//var line:Shape = new Shape(); 
			//			line.graphics.lineStyle(1); 
			//			line.graphics.moveTo(-400, 400); 
			//			//line.graphics.lineTo(40, 20); 
			//			for (var l:int = 0; l < ptsArray.length; l++) 
			//			{
			//				line.graphics.lineTo(ptsArray[l][X],ptsArray[l][Y]); 
			//			}
			//			main.stage.addChild(line); 
			//			
			
			////(ptsArray[0].D," hoil ", actorX);
			if(ptsArray[0].D > actrX)
			{
				// the points arent live so the perspective wont change as the camera moves
				// im not sure what the effect it will have will be
				vect2[0] = [Vec2.get(ptsArray[0].D-2000,ptsArray[0].Y),Vec2.get(ptsArray[0].D,ptsArray[0].Y),Vec2.get(ptsArray[0].D,ptsArray[0].Y-200),Vec2.get(ptsArray[0].D-2000,ptsArray[0].Y-200)]; 
			    
			}else if(ptsArray[ptsArray.length -1].D < actrX)
			{
				vect2[0] =  [Vec2.get(ptsArray[ptsArray.length - 1].D,ptsArray[ptsArray.length - 1].Y),Vec2.get(ptsArray[ptsArray.length - 1].D+2000,ptsArray[ptsArray.length - 1].Y),Vec2.get(ptsArray[ptsArray.length - 1].D+2000,ptsArray[ptsArray.length - 1].Y-200),Vec2.get(ptsArray[ptsArray.length - 1].D,ptsArray[ptsArray.length - 1].Y-200)];
			}else{
				
				for (i= 0; i < ptsArray.length; i++) 
				{
					////("fjjf");
					
					if(ptsArray[i].D >= actrX)
					{
						if(i-2 < 0)
						p0 = null
						else
						p0= ptsArray[i-2];
						p1= ptsArray[i-1];
						p2= ptsArray[i];
						if(i+2 > ptsArray.length)
							p3 = null
						else
						 p3 = ptsArray[i+1]
						break
					}
					////(p1.D, " ", p2.D," hjkl;;; ", actorX);
				}
//				if(p3 == null && p0 == null){
//					vect2[0] = [Vec2.get(p1.D,p1.Y),Vec2.get(p2.D,p2.Y),Vec2.get(p2.D,p2.Y+100),Vec2.get(p1.D,p1.Y+100)];
//					
//				}else if(p3 == null && p0 != null){
//					vect2[1] = [Vec2.get(p0.D,p0.Y),Vec2.get(p1.D,p1.Y),Vec2.get(p1.D,p1.Y+100),Vec2.get(p0.D,p0.Y+100)];
//					vect2[0] = [Vec2.get(p1.D,p1.Y),Vec2.get(p2.D,p2.Y),Vec2.get(p2.D,p2.Y+100),Vec2.get(p1.D,p1.Y+100)];
//					
//				}else if(p3 != null && p0 == null){
//					vect2[0] = [Vec2.get(p1.D,p1.Y),Vec2.get(p2.D,p2.Y),Vec2.get(p2.D,p2.Y+100),Vec2.get(p1.D,p1.Y+100)];
//					vect2[1] = [Vec2.get(p2.D,p2.Y),Vec2.get(p3.D,p3.Y),Vec2.get(p3.D,p3.Y+100),Vec2.get(p2.D,p2.Y+100)];
//					
//					
//				}
//				}else if(p3 != null && p0 != null){
//				vect2 = [Vec2.get(p0.D,p0.Y),Vec2.get(p1.D,p1.Y),Vec2.get(p2.D,p2.Y),Vec2.get(p3.D,p3.Y),Vec2.get(p3.D,p3.Y+100),Vec2.get(p2.D,p2.Y+100),Vec2.get(p1.D,p1.Y+100),Vec2.get(p0.D,p0.Y+100)];
//				}
					 if(p3 == null && p0 == null){
				vect2[0] = [Vec2.get(p1.D,p1.Y),Vec2.get(p2.D,p2.Y),Vec2.get(p2.D,p2.Y-100),Vec2.get(p1.D,p1.Y-100)];
				
				}else if(p3 == null && p0 != null){
					vect2[0] = [Vec2.get(p1.D,p1.Y),Vec2.get(p2.D,p2.Y),Vec2.get(p2.D,p2.Y-100),Vec2.get(p1.D,p1.Y-100)];				
				}else if(p3 != null && p0 == null){
//					throw Error("df")
					vect2[0] = [Vec2.get(p1.D,p1.Y),Vec2.get(p2.D,p2.Y),Vec2.get(p2.D,p2.Y-100),Vec2.get(p1.D,p1.Y-100)];
				}else if(p3 != null && p0 != null){
				
				vect2[0] = [Vec2.get(p0.D,p0.Y),Vec2.get(p1.D,p1.Y),Vec2.get(p1.D,p1.Y-100),Vec2.get(p0.D,p0.Y-100)];
				vect2[1] = [Vec2.get(p1.D,p1.Y),Vec2.get(p2.D,p2.Y),Vec2.get(p2.D,p2.Y-100),Vec2.get(p1.D,p1.Y-100)];
				vect2[2] = [Vec2.get(p2.D,p2.Y),Vec2.get(p3.D,p3.Y),Vec2.get(p3.D,p3.Y-100),Vec2.get(p2.D,p2.Y-100)];

				}
			}
			
			
			
			floorBody.shapes.clear()
			floorBody.shapes.add(new Polygon(vect2[0]));
			if(vect2.length >1){
			floorBody.shapes.add(new Polygon(vect2[1]));
			floorBody.shapes.add(new Polygon(vect2[2]));
			}
			
		}
		
		
		
		// for seeing if your past an object its not that hard 
		// for forward view we can just say that it is 
		// um non roating we just ask where does it interesect our path
		// if you shoot a ray to the right or front if you want and thats it
		// its really pretty simple you just have to put what the objects orientation is
		// i think for now most actually just will deal with orthagonally so i dont even have to worry
		// if i want later i can add the it for any orientation 
		// you could actually even go further if it includes a width, and you can see if you are behind or past it relative
		 
		// you can also do this same trick if you want to move the path independently of sonic
		
		
		// ok lets do this test by test 
		
		/** 
		 * it works, but its a bit of a hack in that not that i dont know why it works, i dont know why it doesnt work with other projections
		 * in other words a projection is a line segment consistantly it doesnt matter how far you put it, but for what i did it does, which means its broken
		 * but its broken in such a way that seems to work, but if you have problems in the future
		 * change it from using hero's zp to whatever character or element your editing, that should help
		 * **/
		public function PointOnPath (pt:Point, convertToSpace:Boolean = false,zdpt:Number = NaN, hintDist:Number = 0):Point
			{
			
			
//				if(convertToSpace)
//				{
//					if(zdpt == NaN)
//					var v:Vector3D = LevelEditor.away3dView.unproject(pt.x,pt.y,Main.liveCamera.hero_mc.zp)
//					else
//					 v = LevelEditor.away3dView.unproject(pt.x,pt.y,zdpt)
//						 
//						 
//
//				}
				// okay this is just a collection of uints, 
				//signifying the lesser
				var lsPoints:Array = []
				
				var si:Vector3D = MainSceneMotor.Unproject(new Vector3D(pt.x, pt.y,Main.liveCamera.hero_mc.zp))
					
					// it should loop through the points in the array and check if its inbetween the two and if it is just tell me where it is, by the t
				for (var j:int = 0; j < ptsArray.length-1; j++) 
				{
					// this should check the local distance from the camera, but umm yeah I dont think I have that formula and hopefully shit just works
					
					//						if(ptsArray[j].X >= pt.x){
					//						if(ptsArray[j+1].X < pt.x)
					//						lsPoints.push(j)
					//						}else 
					var k:Array = MainSceneMotor.twodimlineIntersect(new Vector3D(LevelEditor.awyCam.x,LevelEditor.awyCam.z, 0),new Vector3D(si.x,si.z,0),new Vector3D(ptsArray[j].X,ptsArray[j].Z,0),new Vector3D(ptsArray[j+1].X,ptsArray[j+1].Z,0)) 
			
					if(k[0] > 0 && k[0] <=1){
						//******** Rememebr i did this so that i put in the x z not the x y z
						var u:Number = k[0]
					break
					}
					
				}
				
				if(j == ptsArray.length-1)
					return new Point()
				
				var t:int = lsPoints[0]
				var z:uint = 1
				  ("this is the X", ptsArray[j].X)
//					pt.x=u*(lsPoints[t+1].X-lsPoints[t].X)
					//r u:Number = pt.x/(ptsArray[t+1].X-ptsArray[t].X)
					
				  // tpt represents where i wannna be in space, but not where i wanna be in space
				  var tpt:Object = {X:u*(ptsArray[j+1].X-ptsArray[j].X)+ptsArray[j].X,Z:u*(ptsArray[j+1].Z-ptsArray[j].Z)+ptsArray[j].Z}
					// and since we know where we wanna be in space we take that distance from 
					var dis:Number =Math.sqrt((tpt.X - ptsArray[j].X)*(tpt.X - ptsArray[j].X)+(tpt.Z - ptsArray[j].Z)*(tpt.Z - ptsArray[j].Z))
						dis +=ptsArray[j].D
				var charOnPath:Point = new Point(dis,si.y)
//				if(dis == 0)
//					charOnPath = null
				return charOnPath
			}
		
		public function VectorOnPath (pt:Point, convertToSpace:Boolean = false,zdpt:Number = NaN, hintDist:Number = 0):Object
		{
			
			
			//				if(convertToSpace)
			//				{
			//					if(zdpt == NaN)
			//					var v:Vector3D = LevelEditor.away3dView.unproject(pt.x,pt.y,Main.liveCamera.hero_mc.zp)
			//					else
			//					 v = LevelEditor.away3dView.unproject(pt.x,pt.y,zdpt)
			//						 
			//						 
			//
			//				}
			// okay this is just a collection of uints, 
			//signifying the lesser
			var lsPoints:Array = []
			
			var si:Vector3D = MainSceneMotor.Unproject(new Vector3D(pt.x, pt.y,Main.liveCamera.hero_mc.zp))
			
			// it should loop through the points in the array and check if its inbetween the two and if it is just tell me where it is, by the t
			for (var j:int = 0; j < ptsArray.length-1; j++) 
			{
				// this should check the local distance from the camera, but umm yeah I dont think I have that formula and hopefully shit just works
				
				//						if(ptsArray[j].X >= pt.x){
				//						if(ptsArray[j+1].X < pt.x)
				//						lsPoints.push(j)
				//						}else 
				var k:Array = MainSceneMotor.twodimlineIntersect(new Vector3D(LevelEditor.awyCam.x,LevelEditor.awyCam.z, 0),new Vector3D(si.x,si.z,0),new Vector3D(ptsArray[j].X,ptsArray[j].Z,0),new Vector3D(ptsArray[j+1].X,ptsArray[j+1].Z,0)) 
				
				if(k[0] > 0 && k[0] <=1){
					//******** Rememebr i did this so that i put in the x z not the x y z
					var u:Number = k[0]
					break
				}
				
			}
			
			if(j == ptsArray.length-1)
				return {X:0,Y:0,Z:0}
			
			var t:int = lsPoints[0]
			var z:uint = 1
				trace("this is the X", ptsArray[j].X)
			//					pt.x=u*(lsPoints[t+1].X-lsPoints[t].X)
			//r u:Number = pt.x/(ptsArray[t+1].X-ptsArray[t].X)
			
			// tpt represents where i wannna be in space, but not where i wanna be in space
			var tpt:Object = {X:u*(ptsArray[j+1].X-ptsArray[j].X)+ptsArray[j].X,Z:u*(ptsArray[j+1].Z-ptsArray[j].Z)+ptsArray[j].Z}
			// and since we know where we wanna be in space we take that distance from 
			
			return tpt
		}
		
		// if I nod off make sure z distance is being cecked from the mouse
		/** pt is desired point, on path hintDist is the progress into the path.. say i click a point on the 
		 * path, its possible that more than one point is clicked so you can either check point, x y and z distance based on nearness to 3dpoint vs nearness to a point on path **/
		public function OldPointOnPath (pt:Point, convertToSpace:Boolean = false, hintDist:Number = 0):Point{
			
			// the reason this fails is i dont convert to 3d space
			if(convertToSpace){
			var v:Vector3D = LevelEditor.away3dView.unproject(pt.x,pt.y,500)
			pt.x = v.x
			pt.y = v.y
			}
			var dist:Number = 0
			// okay this is just a collection of uints, 
			//signifying the lesser points in t
			var lsPoints:Array= []
			// umm i is just the final point that we ultimately pick
			var i:uint
			for (var j:int = 0; j < ptsArray.length-1; j++) 
			{
				// this should check the local distance from the camera, but umm yeah I dont think I have that formula and hopefully shit just works
				
//					if(ptsArray[j].X >= pt.x){
//						if(ptsArray[j+1].X < pt.x)
//							lsPoints.push(j)
//					}else 
						if(ptsArray[j].X < pt.x){
						if(ptsArray[j+1].X >= pt.x)
							lsPoints.push(j)
					}
					
					
				}
				
				
				(lsPoints.length, " it is this ", lsPoints[lsPoints.length-1])
				
				//now all i have to do is search through the lsPoint array and look for whichever is either closest to the distance hint, or lowest z if distance hint is 0 then check for errrorrrsrsrsrs, but I think I can just go along and do some of the other stuff before thattatatatatt
				// this variable does double duty it represents the last closest target progress and also the lowest Z 
				// again truthfully it should be the projection on each but yeah that may be expensive so I'm not putting it here
				// if i have problems itll only be two or three points most likely so i can just input it
				var closest:Object = {val:Number, itr:uint}
				for (var k:int = 0; k < lsPoints.length; k++) 
				{
					
					var  n:uint =lsPoints[k]
					
					// hint dist checks if were checking closest distance to sonic,
					// the first if checks Z
					if(hintDist == 0){
						if(k== 0){
							//						closest.val = ptsArray[n].Z
							//						closest.itr = n
							i = n
						}else if(ptsArray[n].Z < ptsArray[i].Z){
							i = n
						}
						
					}else{
						if(k== 0){
							closest = Math.abs(ptsArray[n].D - hintDist)
							i = n
						}else if(Math.abs(ptsArray[n].D - hintDist) <  Math.abs(ptsArray[n].D - hintDist)){
							i=n
						}
						
					}
				}
				(i)
				(i)
				("THE NUMBER IS ",i)
				("THE NUMBER ITS ",i)
			
				
				var a:Number = Math.atan2(ptsArray[i+1].Z - ptsArray[i].Z,ptsArray[i+1].X - ptsArray[i].X)
			dist = (pt.x - ptsArray[i].X)/Math.cos(a)+ ptsArray[i].D
//			var c:Number = Math.sqrt((ptsArray[i+1].X - ptsArray[i].X)*(ptsArray[i+1].X - ptsArray[i].X)+(ptsArray[i+1].Z - ptsArray[i].Z)*(ptsArray[i+1].Z - ptsArray[i].Z))
//			dist = (((pt.x - ptsArray[i].X)/(ptsArray[i+1].X - ptsArray[i].X))*(c))+ptsArray[i].D
			//dist = ptsArray[3].D
			//hyp = adj/cos*
			var charOnPath:Point = new Point(dist,pt.y)
			if(dist == 0)
				charOnPath = null
			return charOnPath
		}
		
		public function SnapToPathXZ(actor:GeneralActor, prgress:Number):void
		{
			
			actrX = prgress - ptsArray[0].D
			////(p1.X," ", prgress + ptsArray[0].X," ",actor.body.userData.graphic.X)
			// actor x is acutally the distance into the path
			//I wanna use ints for this eventually
			// p1[D] is the total distance to the first point in the entire array
			if(p1.D >= 0){
			//D = 0;
			// i put d as zero so it would correspond to the x value, when its complete i need to factor in the z because we need to get the zx distances for each point and
			// i see no reason why it wouldnt just work right off the bat after i figure that out
			// so Dd tells us what the distance its traveled from p1
			var Dd:Number = actrX - p1.D;
			// then dpTrv tells us whats the percentage distance its traveled to get to the next point
			dpTrv = Dd/(p2.D - p1.D);
			//actor.X = ((actorX - p1[D])/p2[D])*(p2[X] - p1[X]) + p1[X];
			actor.myAngle = Math.atan2((p2.Z-p1.Z),(p2.X-p1.X))
				
			// might wanna put these as temp variables but uh yeah letsa keep a going
			actor.X = p1.X + dpTrv*(p2.X - p1.X);
			////(p1.X, p2.X, " tell me", actor.X, " + ", p1.X + dv*(p2.X - p1.X));
			actor.Z = p1.Z + dpTrv*(p2.Z - p1.Z);
			actor.currAngle = localZoffset();
			// the if is just a fix so that you can go past 180 without going negative
			if(actor.currAngle< 0)
				actor.currAngle+=2*Math.PI// TAU
			
			//actor.localZ = -300
			actor.Z = actor.Z + Math.sin(actor.currAngle)*actor.localZ
			actor.X = actor.X + Math.cos(actor.currAngle)*actor.localZ
			//trace(actrX, "sjpi;d be aour z", p1.D," ",p2.D)
			////("this is our angle", actor.currAngle)
				
			}else{
					
			//actor.body.userData.graphic.X = 50
				
			}
			
		}
		
		private function localZoffset():Number
		{
			var angB:Number = Math.atan2((p2.Z-p1.Z),(p2.X-p1.X))
	
				
			
			// this is for testing purposes only but this should work before the rest of the other stuff
			//return angB+Math.PI/2
			// some kind of check to see if we've moved, would be cool, cuz this might be a bit expensive
			// but probably not
			if(p0 == null)
			return angB+Math.PI/2
			else
			var angA:Number =  Math.atan2((p1.Z-p0.Z),(p1.X-p0.X))
			
			if(p3 == null)
				return angB+Math.PI/2
			else
			var angC:Number = Math.atan2((p3.Z-p2.Z),(p3.X-p2.X))
			var deltaAng1:Number = angB + angA/2
			var deltaAng2:Number = angC + angB/2
			var perp1:Number = deltaAng1 +Math.PI/2 // its the same as the next one
			var perp2:Number = deltaAng2 +Math.PI/2
			return (perp2 - perp1)*dpTrv+perp1
			
		}
		
		public function get slope():Number
		{
			return _slope;
		}

		public function set slope(value:Number):void
		{
			_slope = value;
		}

		
	}
}
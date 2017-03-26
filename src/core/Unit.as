package core
{	
	public class Unit {
		public var type:String; //why? mb int?
		public var level:int;
		public var inQueue:Boolean = false;
		
		public function Unit(params:Object) {
			this.parseObject(params);
		}
		
		protected function parseObject(object:Object):void {
			for (var key:String in object) {
				if (object.hasOwnProperty(key) && this.hasOwnProperty(key)) {
					this[key] = object[key];										
				}
			}
		}
	}
}
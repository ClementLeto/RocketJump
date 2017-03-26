package core
{
	public class Process
	{
		public var type:String;
		public var startTime:Number; //timestamp
		public var finishTime:Number;
		
		public function Process(params:Object) {
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
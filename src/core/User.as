package core
{
	public class User {
		public var level:int;
		public var units:Array = [];
		public var processes:Array = [];
		
		public function User(params:Object) {	
			if (params.hasOwnProperty("user")) {
				this.parseObject(params.user);	
			}			
		}
		
		protected function parseObject(object:Object):void {			
			for (var key:String in object) {
				if (object.hasOwnProperty(key) && this.hasOwnProperty(key)) {
					if (key == "units")	{
						this.fillUnits(object.units);
					} else if (key == "processes") {
						this.fillProcesses(object.processes);
					} else {
						this[key] = object[key];	
					}																								
				}
			}
			
		}
		
		private function fillUnits(unitsObj:Object):void {
			if (unitsObj.hasOwnProperty("unit")) {
				var u:Unit;
				if (unitsObj.unit is Array) {
					for (var i:int = 0; i < Helpers.objectLength(unitsObj.unit); i++) {
						u = new Unit(unitsObj.unit[i]);
						this.units[u.type] = u; 				
					}	
				} else {
					u = new Unit(unitsObj.unit);
					this.units[u.type] = u;
				}
			}					
		}
		
		private function fillProcesses(processesObj:Object):void {			
			if (processesObj.hasOwnProperty("upgrade_unit")) {
				var p:Process;
				if (processesObj.upgrade_unit is Array) {
					for (var i:int = 0; i < Helpers.objectLength(processesObj.upgrade_unit); i++) {
						p = new Process(processesObj.upgrade_unit[i]);
						this.processes.push(p);
						if (this.units.hasOwnProperty(p.type)){
							this.units[p.type].inQueue = true;
						}
					}	
				} else {
					p = new Process(processesObj.upgrade_unit);
					this.processes.push(p);
					if (this.units.hasOwnProperty(p.type)){
						this.units[p.type].inQueue = true;
					}
				}
						
			}		
		}
	}
}
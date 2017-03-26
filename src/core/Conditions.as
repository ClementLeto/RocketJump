package core
{
		
	public class Conditions	{
		public var conditions:Object = {};
		private var err1:String = "";
		private var err2:String = "";
		public var errorMsg:String = "";
		
		// mb array of conditions?
		public function Conditions(conditions:Object) {
			this.conditions = conditions.condition;		
		}
		
		public function check(user:User):Boolean {
			return this._check(user, this.conditions, "");
		}
		
		//TODO: refactor this function. its work but does not look beautiful
		private function _check(user:User, conditions:Object, op:String = ""):Boolean {
			var result:Boolean = true;
			for (var key:String in conditions) {
				switch(key) {
					case "and":						
					case "or":
					case "not":
						result = _check(user, conditions[key], key);
						if (!result) return false;
						break;
					default:
						if (conditions[key] is Array) {
							for (var i:int = 0; i<conditions[key].length; i++) {
								result = this.checkCondition(user, key, conditions[key][i]);
								if (!result && op == "and") {
									this.errorMsg = this.err1;
									return false;
								}
								if (result && op == "or") {
									this.errorMsg = this.err1;
									return true;
								}
								if (op == "not") {
									this.errorMsg = this.err2;
									return !result;
								}
							}
						} else {
							result = this.checkCondition(user, key, conditions[key]);
							if (!result && op == "and") {
								this.errorMsg = this.err1;
								return false;
							}
							if (result && op == "or") {
								this.errorMsg = this.err1;
								return true;
							}
							if (op == "not") {
								this.errorMsg = this.err2;
								return !result;
							}
						}
					break;
				}

			}
			
			return result;
		}
		
		private function checkCondition(user:User, key:String, condition:Object):Boolean {
			// TODO: to Constants
			switch(key) {
				case "user_level_gt":					
					this.err1 = "User level mast be grater then "+condition.level;
					this.err2 = "User level mast be less then "+condition.level; 
					return user.level > condition.level;
					break;
				case "unit_level_eq":
					var u:Unit = user.units[condition.type];
					this.err1 = "Unit "+u.type+" not found or level mast be "+condition.level;
					this.err2 = "Unit "+u.type+" level mast not be "+condition.level; 
					return !Helpers.empty(u) && u.level == condition.level;
					break;
				case "unit_upgrade_started":
					this.err1 = "Upgrade process are started";
					this.err2 = "Upgrade process not started"; 
					return user.units[condition.type].inQueue;
					break;
			}
			return true;
		}	

	}
	

}
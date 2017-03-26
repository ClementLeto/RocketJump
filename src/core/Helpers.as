package core
{
	public class Helpers
	{
		public static function empty(variable:*):Boolean {
			
			var isEmpty:Boolean;
			
			if (!variable || variable == null || variable == undefined) {
				isEmpty = true;
			} else if (variable is String) {
				isEmpty = (variable == "" || variable == "0" || variable == "false" || variable == "null");
			} else if (variable is Number || variable is int || variable is uint) {
				isEmpty = (variable == 0);
			} else if (variable is Array) {
				isEmpty = (variable.length == 0);
			} else if (variable is Boolean) {
				isEmpty = (variable == false);
			}
			
			return isEmpty;
		}
		
		public static function objectLength(myObject:Object):int {
			var cnt:int=0;
			
			for (var s:String in myObject) cnt++;
			
			return cnt;
		}
	}
}
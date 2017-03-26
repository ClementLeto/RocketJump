package net
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.xml.XMLDocument;
	
	import mx.rpc.xml.SimpleXMLDecoder;
	
	import core.Helpers;

	public class Request {
		 	
		private var _callback:Function;
		
		public function Request(callback:Function) {
			this._callback = callback;
		}
		
		public static function loadXMLUserById(userId:int, callback:Function):void {
			var link:String = "data/users/user"+userId+".xml";
			var req:Request = new Request(callback);
			req.addRequest(link);			
		}
		
		public static function loadXMLConditions(callback:Function):void {
			var link:String = "data/conditions/conditions.xml";
			var req:Request = new Request(callback);
			req.addRequest(link);
		}
		
		private function addRequest(link:String):void {
			var urlRequest:URLRequest = new URLRequest(link);
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.load(urlRequest);
			urlLoader.addEventListener(Event.COMPLETE, requestCompete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, requestError);			
		}		
		
		private function requestCompete(event:Event):void {
			var XMLResult:XML = new XML(event.currentTarget.data);
			var m:Array = [];			
			var xmlDoc:XMLDocument = new XMLDocument(XMLResult.toString());
			var decoder:SimpleXMLDecoder = new SimpleXMLDecoder(false);
			var resultObj:Object = decoder.decodeXML(xmlDoc);
			if (!Helpers.empty(this._callback)) {				
				this._callback(resultObj);
				this._callback = null;
			}
		}
		
		private function requestError(event:Event):void {
			//TODO: need other structure of response
			if (!Helpers.empty(this._callback)) {				
				this._callback(null);
				this._callback = null;
			}
		}
	}
}
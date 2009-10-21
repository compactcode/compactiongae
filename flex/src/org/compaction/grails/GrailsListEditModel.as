package org.compaction.grails {
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.compaction.model.ListEditModel;
	import org.compaction.sandbox.ListModelMessages;
	import org.compaction.sandbox.ListModelStatus;
	
	public class GrailsListEditModel extends ListEditModel {
		
		private var _messages:ListModelMessages;
		private var _status:ListModelStatus;
		private var _remote:RemoteObject;
		
		public function GrailsListEditModel() {
			_remote = new RemoteObject();

			loadOperation = _remote.getOperation("list");
			createOperation = _remote.getOperation("create"); 
			saveOperation = _remote.getOperation("save");
			destroyOperation = _remote.getOperation("delete");
			
			saveOperation.addEventListener(
				ResultEvent.RESULT,
				function(event:ResultEvent): void {
					GrailsEntity(editModel.edited).id = GrailsEntity(event.result).id;
					editModel.ignoreCurrentChanges();					
				}
			);
			
			_messages = new ListModelMessages(this);
			_status = new ListModelStatus(this);
		}
		
		public function get messages():ListModelMessages {
			return _messages;
		}
		
		public function get status(): ListModelStatus {
			return _status;
		}
		
		public function set modelName(name:String): void {
			_messages.modelName = name;
			_remote.destination = name.toLowerCase() + "Service";
		}
		
	}
}
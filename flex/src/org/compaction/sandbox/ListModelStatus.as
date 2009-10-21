package org.compaction.sandbox {
	import flash.events.Event;
	
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.compaction.action.ISimpleAction;
	import org.compaction.model.IListEditModel;
	
	[Bindable]
	public class ListModelStatus {
		public var executing:Boolean = false;
		public function ListModelStatus(model:IListEditModel) {
			model.editModel.save.beforeExecute(operationBeginning);
			model.load.beforeExecute(operationBeginning);
			model.create.beforeExecute(operationBeginning);
			model.destroy.beforeExecute(operationBeginning);
			
			watch(model.editModel.save, model.editModel.saveOperation);
			watch(model.load, model.loadOperation);
			watch(model.create, model.createOperation);
			watch(model.destroy, model.destroyOperation);
		}
		private function watch(action:ISimpleAction, operation:AbstractOperation): void {
			action.beforeExecute(operationBeginning);
			
			operation.addEventListener(ResultEvent.RESULT, operationComplete);
			operation.addEventListener(FaultEvent.FAULT, operationComplete);
		}		
		private function operationBeginning(ignored:Event=null): void {
			executing = true;
		}
		private function operationComplete(ignored:Event=null): void {
			executing = false;
		}
	}
}
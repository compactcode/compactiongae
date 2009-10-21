package org.compaction.sandbox {
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.StringUtil;
	
	import org.compaction.model.IListEditModel;
	
	[Bindable] 
	public class ListModelMessages {
		
		public var modelName:String;
		public var message:String;
		
		public function ListModelMessages(model:IListEditModel) {
			model.editModel.save.beforeExecute(clearMessage);
			model.editModel.cancel.beforeExecute(clearMessage);
			
			model.load.beforeExecute(clearMessage);
			model.create.beforeExecute(clearMessage);
			model.destroy.beforeExecute(clearMessage);
			
			model.saveOperation.addEventListener(
				ResultEvent.RESULT,
				function(event:ResultEvent): void {
					var template:String = "info:{0} saved successfully.";
					message = StringUtil.substitute(template, modelName);
				}
			);
			model.loadOperation.addEventListener(
				ResultEvent.RESULT,
				function(event:ResultEvent): void {
					var template:String = "info:Displaying {0} {1}.";
					message = StringUtil.substitute(template, event.result.length, modelName.toLowerCase() + "s");
				}
			);
			model.destroyOperation.addEventListener(
				ResultEvent.RESULT,
				function(event:ResultEvent): void {
					var template:String = "info:{0} deleted successfully.";
					message = StringUtil.substitute(template, modelName);
				}
			);
						
			model.loadOperation.addEventListener(FaultEvent.FAULT,displayGenericErrorMessage);
			model.createOperation.addEventListener(FaultEvent.FAULT, displayGenericErrorMessage);
			model.saveOperation.addEventListener(FaultEvent.FAULT, displayGenericErrorMessage);
			model.destroyOperation.addEventListener(FaultEvent.FAULT, displayGenericErrorMessage);
		}
		
		private function displayGenericErrorMessage(event:FaultEvent): void {
			message = "error:That didn't work. Our servers often need a few seconds to warm up. Try again.";
		}
		
		private function clearMessage(): void {
			message = null;
		}
	}
}
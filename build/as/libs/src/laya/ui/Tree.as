package laya.ui {
	import laya.ui.Box;
	import laya.ui.IRender;
	import laya.ui.List;
	import laya.ui.ScrollBar;
	import laya.events.Event;
	import laya.utils.Handler;

	/**
	 * 实例的 <code>selectedIndex</code> 属性发生变化时调度。
	 * @eventType laya.events.Event
	 */

	/**
	 * 节点打开关闭时触发。
	 * @eventType laya.events.Event
	 */

	/**
	 * <code>Tree</code> 控件使用户可以查看排列为可扩展树的层次结构数据。
	 * @example package
	 * @example Laya.init(640, 800);//设置游戏画布宽高、渲染模式
	 * @example import Tree = laya.ui.Tree;
	 */
	public class Tree extends Box implements IRender {

		/**
		 * @private 
		 */
		protected var _list:List;

		/**
		 * @private 
		 */
		protected var _source:Array;

		/**
		 * @private 
		 */
		protected var _renderHandler:Handler;

		/**
		 * @private 
		 */
		protected var _spaceLeft:Number;

		/**
		 * @private 
		 */
		protected var _spaceBottom:Number;

		/**
		 * @private 
		 */
		protected var _keepStatus:Boolean;

		/**
		 * 创建一个新的 <code>Tree</code> 类实例。
		 * <p>在 <code>Tree</code> 构造函数中设置属性width、height的值都为200。</p>
		 */

		public function Tree(){}

		/**
		 * @inheritDoc 
		 * @override 
		 */
		override public function destroy(destroyChild:Boolean = null):void{}

		/**
		 * @override 
		 */
		override protected function createChildren():void{}

		/**
		 * @private 此对象包含的<code>List</code>实例的<code>Event.CHANGE</code>事件侦听处理函数。
		 */
		protected function onListChange(e:Event = null):void{}

		/**
		 * 数据源发生变化后，是否保持之前打开状态，默认为true。
		 * <p><b>取值：</b>
		 * <li>true：保持之前打开状态。</li>
		 * <li>false：不保持之前打开状态。</li>
		 * </p>
		 */
		public var keepStatus:Boolean;

		/**
		 * 列表数据源，只包含当前可视节点数据。
		 */
		public var array:Array;

		/**
		 * 数据源，全部节点数据。
		 */
		public function get source():Array{
				return null;
		}

		/**
		 * 此对象包含的<code>List</code>实例对象。
		 */
		public function get list():List{
				return null;
		}

		/**
		 * 此对象包含的<code>List</code>实例的单元格渲染器。
		 * <p><b>取值：</b>
		 * <ol>
		 * <li>单元格类对象。</li>
		 * <li> UI 的 JSON 描述。</li>
		 * </ol></p>
		 * @implements 
		 */
		public function get itemRender():*{
				return null;
		}
		public  function set itemRender(value:*):void{}

		/**
		 * 滚动条皮肤。
		 */
		public var scrollBarSkin:String;

		/**
		 * 滚动条
		 */
		public function get scrollBar():ScrollBar{
				return null;
		}

		/**
		 * 单元格鼠标事件处理器。
		 * <p>默认返回参数（e:Event,index:int）。</p>
		 */
		public var mouseHandler:Handler;

		/**
		 * <code>Tree</code> 实例的渲染处理器。
		 */
		public var renderHandler:Handler;

		/**
		 * 左侧缩进距离（以像素为单位）。
		 */
		public var spaceLeft:Number;

		/**
		 * 每一项之间的间隔距离（以像素为单位）。
		 */
		public var spaceBottom:Number;

		/**
		 * 表示当前选择的项索引。
		 */
		public var selectedIndex:Number;

		/**
		 * 当前选中的项对象的数据源。
		 */
		public var selectedItem:*;

		/**
		 * @private 获取数据源集合。
		 */
		protected function getArray():Array{
			return null;
		}

		/**
		 * @private 获取项对象的深度。
		 */
		protected function getDepth(item:*,num:Number = null):Number{
			return null;
		}

		/**
		 * @private 获取项对象的上一级的打开状态。
		 */
		protected function getParentOpenStatus(item:*):Boolean{
			return null;
		}

		/**
		 * @private 渲染一个项对象。
		 * @param cell 一个项对象。
		 * @param index 项的索引。
		 */
		protected function renderItem(cell:Box,index:Number):void{}

		/**
		 * @private 
		 */
		private var onArrowClick:*;

		/**
		 * 设置指定项索引的项对象的打开状态。
		 * @param index 项索引。
		 * @param isOpen 是否处于打开状态。
		 */
		public function setItemState(index:Number,isOpen:Boolean):void{}

		/**
		 * 刷新项列表。
		 */
		public function fresh():void{}

		/**
		 * xml结构的数据源。
		 */
		public var xml:XmlDom;

		/**
		 * @private 解析并处理XML类型的数据源。
		 */
		protected function parseXml(xml:*,source:Array,nodeParent:*,isRoot:Boolean):void{}

		/**
		 * @private 处理数据项的打开状态。
		 */
		protected function parseOpenStatus(oldSource:Array,newSource:Array):void{}

		/**
		 * @private 判断两个项对象在树结构中的父节点是否相同。
		 * @param item1 项对象。
		 * @param item2 项对象。
		 * @return 如果父节点相同值为true，否则值为false。
		 */
		protected function isSameParent(item1:*,item2:*):Boolean{
			return null;
		}

		/**
		 * 表示选择的树节点项的<code>path</code>属性值。
		 */
		public function get selectedPath():String{
				return null;
		}

		/**
		 * 更新项列表，显示指定键名的数据项。
		 * @param key 键名。
		 */
		public function filter(key:String):void{}

		/**
		 * @private 获取数据源中指定键名的值。
		 */
		private var getFilterSource:*;
	}

}
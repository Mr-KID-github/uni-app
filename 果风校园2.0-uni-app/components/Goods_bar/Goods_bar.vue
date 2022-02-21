<template>
	<view>
		<view class="background">
			<view class="item_bar" @click="to_tea">
				<text :class="select=='tea'?'select_item':'unselect_item'">水果茶</text>
				<view class="select_background" v-if="select=='tea'"></view>
			</view>
			<image class="divider" src="/static/img/divider.svg"></image>
			<view class="item_bar" @click="to_fishing">
				<text :class="select=='fishing'?'select_item':'unselect_item'">水果捞</text>
				<view class="select_background" v-if="select=='fishing'"></view>
			</view>
			<image class="divider" src="/static/img/divider.svg"></image>
			<view class="item_bar" @click="to_fruit">
				<text :class="select=='fruit'?'select_item':'unselect_item'">水果切</text>
				<view class="select_background" v-if="select=='fruit'"></view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		name:"Goods_switching_bar",
		data() {
			return {
				select: 'tea',
			};
		},
		// props:['func'],
		created() {
			var that = this
			// uni.$on('send_type',(custom_type)=>{
			// 	console.log('接受到定制服务'  + custom_type)
			// 	if (custom_type=='tea'){
			// 		that.to_tea()
			// 	}
			// 	if (custom_type=='fishing'){
			// 		that.to_fishing()
			// 	}
			// 	if (custom_type=='fruit'){
			// 		that.to_fruit()
			// 	}
			// })
		},
		methods: {
			to_tea(){
				this.select = 'tea'
				// 发送信息的页面
				// $emit(eventName, data)  
				uni.$emit('select_bar',this.select)
			},
			to_fishing(){
				this.select = 'fishing'
				// 发送信息的页面
				// $emit(eventName, data)  
				uni.$emit('select_bar',this.select);
			},
			to_fruit(){
				this.select = 'fruit'
				// 发送信息的页面
				// $emit(eventName, data)  
				uni.$emit('select_bar',this.select);
			}
		}
	}
</script>

<style>
.item_bar{
	position: relative;
	text-align: center;
	display: flex;
	align-items: center;
	justify-content: center;
	width: 160rpx;
}
.divider{
	width: 20rpx;
	height: 60rpx;
	margin-top: 20rpx;
}
.background{
	background-color: white;
	height: 100rpx;
	width: 100%;
	display: flex;
	justify-content: space-around;
}
.select_item{
	font-style: normal;
	font-weight: 900;
	font-size: 13.799px;
	line-height: 19px;
	/* identical to box height */
	
	text-align: center;
	letter-spacing: 0.197129px;
	
	color: #3C3C3C;
}
.select_background{
	position: absolute;
	bottom: 0rpx;

	width: 160rpx;
	height: 16rpx;
	
	background: #293F94;
	border-radius: 40rpx 40rpx 0 0;
	box-shadow: 8rpx 0rpx 8rpx rgba(43, 45, 55, 0.01);
}
.unselect_item{
	font-style: normal;
	font-weight: 800;
	font-size: 13.799px;
	line-height: 18px;
	/* identical to box height, or 129% */
	
	text-align: center;
	letter-spacing: 0.197129px;
	
	color: #A4B6C0;
}
</style>

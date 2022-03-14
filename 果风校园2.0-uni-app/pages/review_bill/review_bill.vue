<template>
	<view style="display: flex; flex-direction: column; align-items: center;">
		<view class="Selection">
			<text class="title">订单号：{{id}}</text>
			<view style="display: flex; justify-content: space-between;">
				<view class="order_plan">
					<text class="item" style="color: #293f94;">配送方案</text>
					<text class="content">校园直达 预计送达时间20分钟以内</text>
					<text class="content">地址：{{order.position}}</text>
				</view>
<!-- 				<view class="order_plan">
					<text class="item" style="color: #293f94;">配送次数</text>
					<text class="content">剩余配送 4 次</text>
				</view>	 -->
			</view>
			<view class="order_plan">
				<text class="item" style="color: #293f94;">配送商品</text>
				<text class="content" v-for="item in order.goods">{{item.goods_name}}&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp{{item.goods_num}}份</text>
				<view v-for="item in goods">
					<text class="goods">{{item.name}}</text>
					<text class="goods" style="padding-left: 40rpx;">数量:{{item.num}}</text>
				</view>
			</view>
			<view class="order_plan">
				<text class="item" style="color: #293f94;">总价</text>
				<view style="display: flex; justify-content: space-between;">
					<text class="content">{{order.order_money}}</text>
					<text class="content">{{order.order_time}}</text>
				</view>
			</view>
		</view>
		<view style="display: flex; margin-top: 30rpx;">
			<image src="/static/img/over_start.svg" @click="over_start"></image>
			<image src="/static/img/contact_manager.svg"></image>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				id:"",
				order:'',
				goods: [
				]
			}
		},
		onLoad() {
			this.id=getApp().globalData.order_id
			this.order=getApp().globalData.order//获得配送地址
			this.goods = getApp().globalData.goods
			
		},
		methods: {
			over_start(){
				uni.reLaunch({
					url:'/pages/goods/goods'
				})
			}
		}
	}
</script>

<style>
	image{
		width: 320rpx;
		height: 110rpx;
		margin-left: 20rpx;
		margin-right: 20rpx;
	}
.Selection{
	background-color: #f6f9fc;
	width: 680rpx;
	border-radius: 20rpx;
	margin-top: 30rpx;
	display: flex;
	flex-direction: column;
	padding-bottom: 40rpx;
	padding-top: 40rpx;
}
.order_plan{
	display: flex;
	flex-direction: column;
	margin-left: 40rpx;
	margin-right: 40rpx;
}
.item{
	font-style: normal;
	font-weight: bold;
	font-size: 28rpx;
	line-height: 36rpx;	

	margin-top: 20rpx;

}
.content{
	font-style: normal;
	font-weight: bold;
	font-size: 27rpx;
	line-height: 35rpx;	
	margin-top: 20rpx;

}
.goods{
	font-style: normal;
	font-weight: bold;
	font-size: 27rpx;
	line-height: 35rpx;	
	margin-top: 10rpx;
}
.title{
	font-style: normal;
	font-weight: bold;
	font-size: 36rpx;
	line-height: 36rpx;	
	color: #000000;
	margin-left: 40rpx;
}

</style>

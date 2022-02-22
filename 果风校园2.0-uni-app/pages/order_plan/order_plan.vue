<template>
	<view>
		<view style="align-items: center; display: flex; flex-direction: column;">
			<view class="nutrition_table">
				<text class="nutrition_title">营养价值参考</text>
				<view style="display: flex; margin-top: 20rpx; position: relative; right: 130rpx;">
					<view class="nutrition_value">
						<view class="nutrition_item">
							<image src="/static/img/heat.svg"></image>
							<text>{{20}}k</text>
						</view>
						<text class="nutrition_value_text">热量</text>
					</view>
					<view class="nutrition_value">
						<view class="nutrition_item">
							<image src="/static/img/moisture.svg"></image>
							<text>{{10}}g</text>
						</view>
						<text class="nutrition_value_text">水分</text>
					</view>
					<view class="nutrition_value">
						<view class="nutrition_item">
							<image src="/static/img/sugar.svg" style="margin-right: 5rpx;"></image>
							<text>{{5}}g</text>
						</view>
						<text class="nutrition_value_text">糖分</text>
					</view>
				</view>
			</view>
			
			<!-- 已选商品展示 -->
			<view v-for="item in custom_goods">
				<view class="good" v-if="plan==item.plan_name">
					<view class="img_bcg">
						<image class="good_img" :src="item.goods_img"></image>
					</view>
					<text class="good_introduction">{{item.goods_introduct}}</text>
					<text class="good_name">{{item.goods_name}}</text>		
				</view>
			</view>
		</view>
		<text class="selected_num">已选择 {{2}}份 商品</text>
		<!-- 底部导航栏 -->
		<view style="height: 110rpx;"></view>
		<custom_bar customstep="/static/img/customstep2.svg" :plan="plan"></custom_bar>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				custom_goods:[],
				plan: '',
			}
		},
		onLoad() {
			this.plan = getApp().globalData.select_plan
			this.custom_goods = getApp().globalData.custom_cert
		},
		methods: {
			
		}
	}
</script>

<style>
	page{
		background-color: #f6f9fc;
	}
.good{
	width: 680rpx;
	height: 170rpx;
	background-color: white;
	border-radius: 20rpx;
	display: flex;
	align-items: center;
	margin-top: 30rpx;
}
.good_img{
	width: 95rpx;
	height: 95rpx;
	border-radius: 50rpx;
	background-color: #007AFF;
}
.img_bcg{
	position: relative;
	left: 25rpx;
	display: flex;
	 justify-content: center; align-items: center; 
	 background-color: #7cc7d0; width: 110rpx; height: 110rpx;
	  border-radius: 30rpx;
}
.good_introduction{
	font-style: normal;
	font-weight: bold;
	font-size: 28rpx;
	line-height: 36rpx;
	
	color: #000000;
	margin-left: 40rpx;
}
.good_name{
	font-style: normal;
	font-weight: bold;
	font-size: 28rpx;
	line-height: 36rpx;	
	color: #000000;
	position: absolute;
	right: 60rpx;
}
	.nutrition_value{
		display: flex;
		flex-direction: column;
		margin-right: 30rpx;
	}
	.nutrition_value_text{
		font-style: normal;
		font-weight: bold;
		font-size: 20rpx;
		line-height: 26rpx;
		/* identical to box height */
		position: relative;
		left: 10rpx;
		letter-spacing: 20rpx;
		
		color: #979797;
	}
	.nutrition_item{
		display: flex;
	}
	.nutrition_item image{
		width: 34rpx;
		height: 34rpx;
		
	}
	.nutrition_item text{
		font-style: normal;
		font-weight: normal;
		font-size: 28rpx;
		line-height: 36rpx;
		color: #000000;
	}
	.nutrition_title{
		font-style: normal;
		font-weight: bold;
		font-size: 28rpx;
		line-height: 36rpx;
		color: #000000;
		position: relative;
		right: 200rpx;
	}
	.nutrition_table{
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		width: 690rpx;
		height: 140rpx;
		border-radius: 20rpx;
		background-color: white;
		margin-top: 40rpx;
	}
.selected_num{
	position: relative;
	top: 20rpx;
	margin-left: 440rpx;
	font-style: normal;
	font-weight: bold;
	font-size: 36rpx;
	line-height: 46rpx;
	/* identical to box height */
	
	color: #000000;
}
</style>

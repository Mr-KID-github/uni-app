<template>
	<view>
		<!-- 步骤2 的导航栏 -->
		<step_bar :step="step"></step_bar>
		<!-- 订单内容 -->
		<view class="content_bck">
			<view class="content">
				<view class="content_item"  v-for="item in cert">
					<view class="good_content">
						<text class="content_name">{{item.goods_name}}</text>
						<text class="content_num">{{item.goods_price}} 元 × {{item.goods_num}} 份</text>
					</view>
					<text class="content_price">￥{{item.goods_price * item.goods_num}}</text>
				</view>
				<view style="border: 2rpx solid #979797; width: 90%; margin-left: 5%; margin-right: 5%;"></view>
				<view class="tip">
					<text class="tip_text">服务费</text>
					<text>￥5</text>
				</view>
				<view style="border: 2rpx solid #979797; width: 90%; margin-left: 5%; margin-right: 5%;"></view>
				<view class="total_price">
					<view>Total:</view>
					<text>￥{{total_price + 5}}</text>
				</view>
			</view>
		</view>
		<!-- 地址 -->
		<view style="margin-bottom: 180rpx;">
			<position></position>
		</view>
		<view class="pay">
			<image src="/static/img/pay.svg"></image>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				step: 2,
				cert: [
					
				],	// 购物车
				total_price: 0
			}
		},
		onLoad() {
			this.cert = getApp().globalData.cert
			this.total_price = getApp().globalData.total_price
		},
		methods: {
			
		}
	}
</script>

<style>
page{
	background-color: #f6f9fc;
}
.pay{
	background-color: white;
	width: 100%;
	height: 150rpx;
	position: fixed;
	bottom: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 25rpx 25rpx 0 0;
}
.pay image{
	width: 700rpx;
	height: 100rpx;
}
.total_price{
	display: flex;
	position: relative;
	left: 65%;
	margin-bottom: 20rpx;
	margin-top: 20rpx;
}
.total_price view{
	font-style: normal;
	font-weight: normal;
	font-size: 18px;
	line-height: 23px;
	/* identical to box height */
	
	text-align: center;
	letter-spacing: -0.3px;
	
	color: #000000;
}
.total_price text{
	font-style: normal;
	font-weight: bold;
	font-size: 18px;
	line-height: 23px;
	/* identical to box height */
	
	text-align: center;
	letter-spacing: -0.3px;
	
	color: #000000;
}
.tip{
	display: flex;
	justify-content: space-between;
	margin: 5%;
}
.tip_text{
	font-style: normal;
	font-weight: bold;
	font-size: 18px;
	line-height: 23px;
	/* identical to box height */
	
	text-align: center;
	letter-spacing: -0.3px;
	
	color: #000000;
}
.content_bck{
	width: 100%;
	display: flex;
	justify-content: center;
}
.content{
	width: 680rpx;
	background-color: white;
	margin-top: 40rpx;
	border-radius: 25rpx;
}
.content_item{
	display: flex;
	justify-content: space-between;
	margin: 35rpx;
}
.good_content{
	display: flex;
	flex-direction: column;
}
.content_name{
	font-style: normal;
	font-weight: bold;
	font-size: 18px;
	line-height: 23px;
	/* identical to box height */
	
	letter-spacing: -0.3px;
	
	color: #000000;

}

.content_num{
	font-style: normal;
	font-weight: normal;
	font-size: 28rpx;
	line-height: 40rpx;
	/* identical to box height */
	
	letter-spacing: -0.3px;
	
	color: #979797;
}

.content_price{
	font-style: normal;
	font-weight: bold; 
	font-size: 18px;
	line-height: 23px;
	/* identical to box height */
	
	text-align: center;
	letter-spacing: -0.3px;
	
	color: #000000;
}
</style>

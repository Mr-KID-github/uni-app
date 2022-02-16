<template>
	<view>
		<!-- 步骤2 的导航栏 -->
		<step_bar :step="step"></step_bar>
		<!-- 订单内容 -->
		<view class="content_bck">
			<view class="content">
				<view class="content_item"  v-for="item in cert">
					<view class="good_content">
						<text class="content_name">{{item.good_name}}</text>
						<text class="content_num">{{item.good_num}} 份</text>
					</view>
					<text class="content_price">￥{{item.good_price}}</text>
				</view>
				<view style="border: 2rpx solid #979797; width: 90%; margin-left: 5%; margin-right: 5%;"></view>
				<view class="tip">
					<text class="tip_text">服务费</text>
					<text>￥5</text>
				</view>
				<view style="border: 2rpx solid #979797; width: 90%; margin-left: 5%; margin-right: 5%;"></view>
				<view class="total_price">
					<view>Total:</view>
					<text>￥{{total}}</text>
				</view>
			</view>
		</view>
		<position></position>
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
					{
						good_name: '炭烧水果捞',
						good_num: 1,
						good_price: 10	
					},
					{
						good_name: '炭烧水果捞',
						good_num: 1,
						good_price: 10	
					},
					{
						good_name: '炭烧水果捞',
						good_num: 1,
						good_price: 10	
					},
				],
				total: 75
			}
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
	position: absolute;
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
	position: absolute;
	right: 10%;
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
	height: 670rpx;
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
	
	text-align: center;
	letter-spacing: -0.3px;
	
	color: #000000;

}

.content_num{
	font-style: normal;
	font-weight: normal;
	font-size: 15px;
	line-height: 20px;
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

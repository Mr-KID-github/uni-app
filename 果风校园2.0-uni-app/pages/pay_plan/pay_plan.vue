<template>
	<view>
		<view style="align-items: center; display: flex; flex-direction: column;">
			<!-- 订单日期 -->
			<view class="order_date">
				<text class="date_text">下单时间为: 10/26/2022</text>
				<text class="date_text">￥{{76.00}}</text>
			</view>
			
			<!-- 配送信息 -->
			<view class="Delivery">
				<text class="Delivery_text">Delivery</text>
				<!-- 配送时间 -->
				<view class="Delivery_content">
					<view class="Delivery_img">
						<image src="/static/img/delivery_car.svg"></image>
					</view>
					<view class="content_detail">
						<view><text>您的订单将会每周配送,</text><text style="color: #293f94;">总计将配送5次,</text></view>
						<view><text>配送时间为</text><text style="color: #293f94;">8:00AM - 12:30PM.</text></view>
					</view>
				</view>
				<!-- 联系方式 -->
				<view class="contact">
					<view class="Number">
						<text class="title">Number</text>
						<text class="contact_text">178 7361 8995</text>
					</view>
					<view class="Email">
						<text class="title">Email</text>
						<text class="contact_text">order@192.com</text>
					</view>
				</view>
			</view>
			<button class="pay_button">支付</button>
		</view>
		<!-- 底部导航 -->
		<view style="height: 180rpx;"></view>
		<custom_bar step_name="pay_plan"></custom_bar>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				plan: ''
			}
		},
		onLoad() {
			this.plan = getApp().globalData.select_plan
		},
		methods: {
			
		}
	}
</script>

<style>
	.pay_button{
		margin-top: 30rpx;
		width: 680rpx;
		height: 100rpx;
		background-color: #2eb17f;
		font-style: normal;
		font-weight: bolder;
		font-size: 36rpx;
		text-align: center;
		color: #FFFFFF;
	}
	.contact{
		display: flex;
		justify-content: space-between;
		margin-top: 25rpx;
	}
	.Number{
		display: flex;
		flex-direction: column;
	}
	.Email{
		display: flex;
		flex-direction: column;
	}
	.title{
		font-style: normal;
		font-weight: 800;
		font-size: 30rpx;
		color: #000000;
	}
	.contact_text{
		font-style: normal;
		font-weight: 800;
		font-size: 30rpx;
		color: #515151;
		margin-top: 10rpx;
	}
	.content_detail{
		margin-right: 20rpx;
		height: 60rpx;
		font-style: normal;
		font-weight: 800;
		font-size: 25rpx;
		color: #000000;
	}
	.Delivery_img{
		background-color: #e0e9ef;
		border-radius: 10rpx;
		width: 70rpx;
		height: 70rpx;
		display: flex;
		justify-content: center;
		align-items: center;
		margin-left: 20rpx;
		margin-right: 30rpx;
	}
	.Delivery_img image{
		height: 50rpx;
		position: relative;
		bottom: 5rpx;
	}
	.Delivery_content{
		width: 100%;
		margin-top: 20rpx;
		border-radius: 15rpx;
		height: 100rpx;
		background-color: #f6f9fc;
		align-items: center;
		display: flex;
	}
	.Delivery_text{
		font-style: normal;
		font-weight: 800;
		font-size: 28rpx;
		line-height: 40rpx;
		color: #000000;
	}
	.Delivery{
		display: flex;
		flex-direction: column;
		margin-top: 30rpx;
		padding: 25rpx;
		background-color: white;
		width: 640rpx;
		height: 250rpx;
		border-radius: 20rpx;
	}
	.date_text{
		font-style: normal;
		font-weight: 900;
		font-size: 28rpx;
		line-height: 40rpx;
		margin-left: 30rpx;
		margin-right: 30rpx;
		color: #000000;
	}
	.order_date{
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 690rpx;
		height: 70rpx;
		border-radius: 15rpx;
		background-color: white;
		margin-top: 40rpx;
	}
	page{
		background-color: #f6f9fc;
	}
.remind{
	position: fixed;
	bottom: 120rpx;
	font-style: normal;
	font-weight: 800;
	font-size: 28rpx;
	line-height: 40rpx;
	color: #000000;
}
.grad{
	position: fixed;
	bottom: 110rpx;
	height: 80rpx;
	width: 100%;
}
</style>

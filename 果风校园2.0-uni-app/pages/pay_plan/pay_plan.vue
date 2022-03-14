<template>
	<view>
		<view style="align-items: center; display: flex; flex-direction: column;">
			<!-- 订单日期 -->
			<view class="order_date">
				<text class="date_text">下单时间: {{order.time}}</text>
				<text class="date_text">￥{{order.price}}</text>
			</view>

			<!-- 配送信息 -->
			<view class="Delivery">
				<text class="Delivery_text">配送计划</text>
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
						<text class="title">电话</text>
						<text class="contact_text">{{order.phone}}</text>
					</view>
					<view class="Email">
						<text class="title">地址</text>
						<text class="contact_text">{{order.address}}</text>
					</view>
				</view>
			</view>
			<button class="pay_button" @click="push_order">支付</button>
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
				plan: '',
				order: {
					user_id:'',
					goods: [], //商品信息
					phone: "", //电话
					address: "", //地址
					price: 0, //总价格
					time: '',//订单时间
					Notification_Check: '',//订单提醒
					order_status: '未支付',
				},
				goods: '',

			}
		},
		onLoad() {
			this.order.user_id=getApp().globalData.openid
			this.goods = getApp().globalData.custom_cert
			this.plan = getApp().globalData.select_plan
			//获取时间函数---
			this.order.time = this.getTime()
			//获取地址和电话
			this.order.phone = getApp().globalData.position.phone
			this.order.address = getApp().globalData.position.school + '|' + getApp().globalData.position.apartment + '|' +
				getApp().globalData.position.dormitory
			//获取定制提醒信息
			if (this.plan == '方案一') {

				this.order.Notification_Check = getApp().globalData.Notification_Check.N1

			} else if (this.plan == '方案二') {
				this.order.Notification_Check = getApp().globalData.Notification_Check.N2

			} else {
				this.order.Notification_Check = getApp().globalData.Notification_Check.N3

			}
			//获取当前方案的商品，放在订单数组中
			var that = this
			for (let i = 0; i < this.goods.length; i++) {
				var item = this.goods[i]
				if (item.plan_name == that.plan) {
					that.order.goods += item
					that.order.price += Number(item.goods_price)
					console.log(that.order.goods)
				}
			}


		},
		methods: {
			//获取时间函数
			getTime: function() {
				var date = new Date(),
					year = date.getFullYear(),
					month = date.getMonth() + 1,
					day = date.getDate(),
					hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours(),
					minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes(),
					second = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
				month >= 1 && month <= 9 ? (month = "0" + month) : "";
				day >= 0 && day <= 9 ? (day = "0" + day) : "";
				var timer = year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
				return timer;
			},
		}
	}
</script>

<style>
	.pay_button {
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

	.contact {
		display: flex;
		justify-content: space-between;
		margin-top: 25rpx;
	}

	.Number {
		display: flex;
		flex-direction: column;
	}

	.Email {
		display: flex;
		flex-direction: column;
	}

	.title {
		font-style: normal;
		font-weight: 800;
		font-size: 30rpx;
		color: #000000;
	}

	.contact_text {
		font-style: normal;
		font-weight: 800;
		font-size: 30rpx;
		color: #515151;
		margin-top: 10rpx;
	}

	.content_detail {
		margin-right: 20rpx;
		height: 60rpx;
		font-style: normal;
		font-weight: 800;
		font-size: 25rpx;
		color: #000000;
	}

	.Delivery_img {
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

	.Delivery_img image {
		height: 50rpx;
		position: relative;
		bottom: 5rpx;
	}

	.Delivery_content {
		width: 100%;
		margin-top: 20rpx;
		border-radius: 15rpx;
		height: 100rpx;
		background-color: #f6f9fc;
		align-items: center;
		display: flex;
	}

	.Delivery_text {
		font-style: normal;
		font-weight: 800;
		font-size: 28rpx;
		line-height: 40rpx;
		color: #000000;
	}

	.Delivery {
		display: flex;
		flex-direction: column;
		margin-top: 30rpx;
		padding: 25rpx;
		background-color: white;
		width: 640rpx;
		height: 250rpx;
		border-radius: 20rpx;
	}

	.date_text {
		font-style: normal;
		font-weight: 900;
		font-size: 28rpx;
		line-height: 40rpx;
		margin-left: 30rpx;
		margin-right: 30rpx;
		color: #000000;
	}

	.order_date {
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 690rpx;
		height: 70rpx;
		border-radius: 15rpx;
		background-color: white;
		margin-top: 40rpx;
	}

	page {
		background-color: #f6f9fc;
	}

	.remind {
		position: fixed;
		bottom: 120rpx;
		font-style: normal;
		font-weight: 800;
		font-size: 28rpx;
		line-height: 40rpx;
		color: #000000;
	}

	.grad {
		position: fixed;
		bottom: 110rpx;
		height: 80rpx;
		width: 100%;
	}
</style>

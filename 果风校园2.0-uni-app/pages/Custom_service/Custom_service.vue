<template>
	<view>
		<!-- 导入方案选择组件 -->
		<plan_select></plan_select>
		<view class="plan_goods">
			<text class="plan_goods_title">科学-搭配</text>
			<!-- 导入计划商品组件 -->
			<plan_good price="10" plan_introduct="每次配送一到两种水果" good_name="苹果&香蕉&西瓜各种水果" img_url="/static/img/fruit1.jpg"></plan_good>
			<plan_good price="10" plan_introduct="配送一次原味水果捞" good_name="原味水果捞" img_url="/static/img/fish0.png"></plan_good>
			<plan_good price="0" plan_introduct="果茶" good_name="免费赠送一次果茶" img_url="/static/img/tea1.jpg"></plan_good>
		</view>
		<view class="plan_time">
			<text class="plan_title">配送次数 & 配送周期</text>
			<view class="time_content">
				<view class="time_item">
					<image src="/static/img/times.svg"></image>
					<text>5</text>
					<text>times</text>
				</view>
				<view class="time_item">
					<image src="/static/img/days.svg"></image>
					<text>7</text>
					<text>days</text>
				</view>
			</view>
		</view>
		<view class="Notification">
			<text class="plan_title">
				配送时间
			</text>
			<view style="display: flex; align-items: center;">
				<view class="Notification_item">
					<image src="/static/img/Notification.svg"></image>
					<text>10:00 AM</text>
				</view>
				<text class="Notification_Check_text">是否-提醒</text>
				<image src="/static/img/Notification_Check.svg" class="Notification_img"  v-if="Notification_Check" @click="change_Check"></image>
				<image src="/static/img/Notification_UnCheck.svg" class="Notification_img" v-if="!Notification_Check" @click="change_Check"></image>
			</view>
		</view>
		<view class="Total">
			<text class="Total_price">Total:￥{{20}}</text>
			<text class="Total_extend">选择定制配送套餐，每周赠送一杯果茶</text>
		</view>
		<view class="button">
			<image src="/static/img/REVIEW_MENU.svg"></image>
			<image src="/static/img/CHECK_OUT.svg"></image>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				Notification_Check: true
			}
		},
		methods: {
			change_Check(){
				this.Notification_Check = !this.Notification_Check
			}
		}
	}
</script>

<style>
page{
	background-color: #ffffff;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.plan_goods{
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	background-color: #F1F4F7;
	width: 670rpx;
	height: 500rpx;
	border-radius: 20rpx;
	margin-top: 20rpx;
}

.plan_goods_title{
	font-style: normal;
	font-weight: bold;
	font-size: 36rpx;
	line-height: 46rpx;
	position: relative;
	right: 210rpx;
	color: #000000;
}

.plan_time{
	width: 670rpx;
}
.plan_title{
	font-style: normal;
	font-weight: 600;
	font-size: 30rpx;
	line-height: 76rpx;
	
	color: #0A0909;
}

.time_content{
	display: flex;
	justify-content: space-between;
}

.time_item{
	width: 320rpx;
	height: 95rpx;
	background-color: #f8f8f6;
	border-radius: 20rpx;
	display: flex;
	align-items: center;
}
.time_item image{
	width: 42rpx;
	height: 42rpx;
	margin-left: 30rpx;
	margin-right: 30rpx;
}

.time_item text{
	font-style: normal;
	font-weight: 600;
	font-size: 30rpx;
	line-height: 75rpx;
	margin-right: 42rpx;
	
	color: #0A0909;
}
.Notification_item{
	width: 350rpx;
	height: 85rpx;
	background-color: #f8f8f6;
	border-radius: 20rpx;
	display: flex;
	align-items: center;
}
.Notification_item image{
	width: 40rpx;
	height: 40rpx;
	margin-left: 30rpx;
}
.Notification_item text{
	font-style: normal;
	font-weight: 600;
	font-size: 34rpx;
	line-height: 75rpx;
	margin-left: 30rpx;
	color: #0A0909;

}
.Notification_img{
	width: 96rpx;
	height: 96rpx;
}
.Notification_Check_text{
	font-style: normal;
	font-weight: bold;
	font-size: 36rpx;
	line-height: 46rpx;
	margin-left: 30rpx;
	margin-right: 22rpx;
	color: #000000;
}
.Total_price{
	font-style: normal;
	font-weight: bold;
	font-size: 50rpx;
	line-height: 60rpx;
	
	color: #000000;
}
.Total{
	margin-top: 40rpx;
	display: flex;
	flex-direction: column;
}
.Total_extend{
	font-style: normal;
	font-weight: normal;
	font-size: 28rpx;
	line-height: 36rpx;
	color: #000000;

}

.button{
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 40rpx;
	margin-bottom: 50rpx;
}

.button image{
	width: 330rpx;
	height: 100rpx;
	margin-right: 10rpx;
}
</style>

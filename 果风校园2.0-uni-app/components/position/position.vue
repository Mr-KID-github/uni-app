<template>
	<view>
		<view class="background" @click="modify_position">
			<image src="/static/img/position_logo.svg" class="position_img"></image>
			<view class="position_text">
				<text>{{school + apartment + dormitory}}</text>
				<view class="position_user">
					<text>{{phone}}</text>
				</view>
			</view>
			<image src="/static/img/arrow3.svg" class="arrow3"></image>
		</view>
	</view>
</template>

<script>
	export default {
		name:"position",
		data() {
			return {
				school: getApp().globalData.position['school'],
				apartment: getApp().globalData.position['apartment'],
				dormitory: getApp().globalData.position['dormitory'],
				phone: getApp().globalData.position['phone'],
			};
		},
		methods: {
			modify_position(){
				uni.navigateTo({
					url:"/pages/address/address"
				})
			}
		}
	}
</script>

<style>
.background{
	background-color: #FFFFFF;
	margin: 5%;
	width: 90%; height: 100rpx;
	margin-bottom: 180rpx;
	border-radius: 20rpx;
	display: flex;
	align-items: center;
}
.position_img{
	width: 60rpx;
	height: 60rpx;
	position: absolute;
	left: 8%;
}

.position_user text{
	font-style: normal;
	font-weight: normal;
	font-size: 24rpx;
	line-height: 30rpx;
	color: #979797;
}
.position_text{
	font-style: normal;
	font-weight: normal;
	font-size: 28rpx;
	line-height: 36rpx;
	/* identical to box height */
	position: absolute;
	left: 18%;
	color: #000000;
}
.arrow3 {
	width: 30rpx;
	height: 30rpx;
	position: absolute;
	right: 8%;
}
</style>

<template>
	<view>
		<view class="background">
			<image src="/static/img/position_logo.svg" class="position_img"></image>
			<view class="position_text">
				<text>麻省理工学院湖西校区六公寓207</text>
				<view class="position_user">
					<text>白浪</text>
					<text>19898743829</text>
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
				
			};
		}
	}
</script>

<style>
.background{
	background-color: #FFFFFF;
	margin: 5%;
	width: 90%; height: 100rpx;
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
.position_user{
	display: flex;
}
.position_user text{
	font-style: normal;
	font-weight: normal;
	font-size: 12px;
	line-height: 15px;
	text-align: center;
	letter-spacing: -0.3px;
	margin-right: 10rpx;
	color: #979797;
}
.position_text{
	font-style: normal;
	font-weight: normal;
	font-size: 14px;
	line-height: 18px;
	/* identical to box height */
	
	text-align: center;
	letter-spacing: -0.3px;
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

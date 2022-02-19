<template>
	<view>
		<view class="plan_bcg">
			<text class="plan_text">选择您要配送的果茶&果捞&水果方案</text>
			<view class="plan">
				<view class="item">
					<view class="item_name">
						方案一
					</view>
					<text class="item_price">￥20.00</text>
				</view>
				<view class="item">
					<view class="item_name2">
						方案二
					</view>
					<text class="item_price">￥20.00</text>
				</view>
				<view class="item">
					<view class="item_name2">
						自定义
					</view>
					<text class="item_price">￥20.00</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		methods: {
			
		}
	}
</script>

<style>
.item{
	margin: 10rpx;
	display: flex;
	flex-direction: column;
	width: 190rpx;
	height: 165rpx;
}
.item_name{
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #2eb17f;
	border-radius: 25rpx;
	width: 190rpx;
	height: 120rpx;
	
	font-style: normal;
	font-weight: bold;
	font-size: 36rpx;
	line-height: 46rpx;
	/* identical to box height */
	
	text-align: center;
	
	color: #FFFFFF;
}
.item_name2{
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #FFFFFF;
	border-radius: 25rpx;
	width: 190rpx;
	height: 120rpx;
	
	font-style: normal;
	font-weight: bold;
	font-size: 36rpx;
	line-height: 46rpx;
	/* identical to box height */
	
	text-align: center;
	
	color: #000000;
}
.plan{
	display: flex;
}
.item_price{
	margin-top: 10rpx;
	font-style: normal;
	font-weight: bold;
	font-size: 28rpx;
	line-height: 36rpx;
	/* identical to box height */
	
	text-align: center;

	
	color: #000000;
}
.plan_bcg{
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	background-color: #F1F4F7;
	width: 670rpx;
	height: 280rpx;
	border-radius: 20rpx;
	margin-top: 20rpx;
	padding-top: 24rpx;
}
.plan_text{
	position: relative;
	right: 45rpx;
	bottom: 10rpx;
	font-style: normal;
	font-weight: bold;
	font-size: 32rpx;
	line-height: 36rpx;
	/* identical to box height */
	
	color: #000000;
}
</style>

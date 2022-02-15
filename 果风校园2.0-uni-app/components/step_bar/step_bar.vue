<template>
	<view>
		<view class="background">
			<view class="content">
				<text class="text">Step 1.选择你的商品</text>
				<image src="/static/img/arrow.svg" class="arrow"></image>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		name:"step_bar",
		data() {
			return {
				
			};
		}
	}
</script>

<style>
	.text{
		font-style: normal;
		font-weight: 800;
		font-size: 13.7716px;
		line-height: 19px;
		letter-spacing: 0.196737px;
		color: #3C3C3C;
	}
	.arrow{
		width: 45rpx;
		height: 45rpx;
	}
	.background{
		padding-top: 20rpx;
		display: flex;
		justify-content: center;
	}
	.content{
		background-color: white;
		width: 680rpx; height: 65rpx;
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 10rpx;
		border-radius: 20rpx;
	}
</style>

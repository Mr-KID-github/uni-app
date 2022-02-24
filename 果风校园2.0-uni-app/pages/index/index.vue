<template>
	
	<view class="home">
		 <swiper indicator-dots circular>
			 <swiper-item>
				 <image src="/static/img/background_img.svg"></image>
			 </swiper-item>
			 <swiper-item>
				 <image src="/static/img/background_img.svg"></image>
			 </swiper-item>
		 </swiper>
		<view class="shop">
			<text>果捞&果茶&果切</text>
		</view>
		<view class="science">
			<image class="science_active" src="/static/img/custom_distribution.svg" @click="to_Custom_goods"></image>
			<image class="science_active" src="/static/img/Selectself.svg" @click="to_goods"></image>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		onLoad() {

		},
		methods: {
			to_Custom_goods(){
				uni.redirectTo({
					url:"/pages/Custom_service/Custom_service"
				})
			},
			to_goods(){
				uni.redirectTo({
					url:"/pages/goods/goods"
				})
			}
		}
	}
</script>

<style lang="scss">
	.home{
		width: 100%;
		swiper{
			width: 750rpx;
			height: 628rpx;
			image{
				width: 100%;
				height: 100%;
			}
		}
		.shop{
			position: absolute;
			width: 100%;
			height: 500rpx;
			top: 670rpx;
			left: 40rpx;
			
			font-style: normal;
			font-weight: 800;
			font-size: 36rpx;
			line-height: 40rpx;
			color: #000000;
		}
		.science{
			position: relative;
			width: 100%;
			margin-top: 100rpx;
		}
		.science_active{
			position: relative;
			width: 100%;
			height: 150rpx;
			margin-top: 40rpx;
		}
	}
	
</style>

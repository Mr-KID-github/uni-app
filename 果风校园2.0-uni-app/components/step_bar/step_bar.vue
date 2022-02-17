<template>
	<view>
		<view class="background" v-if="step==1" @click="to_order">
			<view class="content">
				<text class="text">Step 1.选择您的商品</text>
				<image src="/static/img/arrow.svg" class="arrow"></image>
			</view>
		</view>
		<view class="background" v-if="step==2">			
			<view class="content">
				<text class="text">Step 2.确认您的订单</text>
				<image src="/static/img/arrow.svg" class="arrow" style="transform:rotate(90deg);"></image>
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
		},
		props:['step'],	//接受父组件传递过来的步骤信息
		created() {

		},
		methods:{
			// 跳转到order_confirm界面
			to_order(){
				console.log("跳转order_confirm")
				uni.navigateTo({
					url:"/pages/order_confirm/order_confirm",
					// 成功跳转则计算购物车总价格并赋值给全局total_price
					success() {
						let appdata = getApp().globalData
						appdata.total_price = 0
						for (let i = 0; i < appdata.cert.length; i++){
							var item = appdata.cert[i]
							appdata.total_price = appdata.total_price + item.goods_num * item.goods_price
						}
						console.log("总价：" + appdata.total_price)
					}
				})
			}

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
		margin-left: 30rpx;
	}
	.arrow{
		width: 45rpx;
		height: 45rpx;
		margin-right: 30rpx;
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

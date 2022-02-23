<template>
	<view>
		<view style="position: fixed; bottom: 0;" @click="get_position">
			<image :src="customstep" class="customstep_img" mode="widthFix"></image>
		</view>
	</view>
</template>

<script>
	export default {
		name:"custom_bar",
		data() {
			return {
				
			};
		},
		props:['customstep'],
		methods:{
			get_position(e){
				console.log(e)
				if (e.detail.x<=120){
					uni.navigateBack({
						url: "/pages/Custom_goods/Custom_goods"	
					})
				} else if (e.detail.x<225 && e.detail.x>120){
					if (getApp().globalData.custom_cert.length==0){
						uni.showModal({
							showCancel: false,
							content: "请选择配送商品",
						})
					} else {
						uni.navigateTo({
							url: "/pages/order_plan/order_plan"
						})	
					}
				} else {
					// 调用支付接口
					// uni.requestPayment({
						
					// })
					// 支付成功则跳转订单界面
					uni.navigateTo({
						url: "/pages/pay_plan/pay_plan"	
					})
				}
			}
		}
	}
</script>

<style>
.customstep_img{
	width: 100%;
	height: 110rpx;
	position: fixed;
	bottom: 0;
}
</style>

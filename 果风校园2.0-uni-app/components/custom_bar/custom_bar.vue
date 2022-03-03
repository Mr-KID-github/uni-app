<template>
	<view>
		<view style="display: flex; justify-content:center; position:fixed; bottom: 0;">
			<image class="customstep_img1" id="select_good" @click="click_step" mode="aspectFit" :src="step=='select_good'?step1:unstep1"></image>
			<image class="customstep_img2" id="order_plan" @click="click_step" mode="aspectFit" :src="step=='order_plan'?step2:unstep2"></image>
			<image class="customstep_img3" id="pay_plan" @click="click_step" mode="" :src="step=='pay_plan'?step3:unstep3"></image>
		</view>
	</view>
</template>

<script>
	export default {
		name:"custom_bar",
		data() {
			return {
				step:'',
				step1: "/static/img/customstep1.svg",
				unstep1: "/static/img/customstep1un.svg",
				step2: "/static/img/customstep2.svg",
				unstep2: "/static/img/customstep2un.svg",
				step3: "/static/img/customstep3.svg",
				unstep3: "/static/img/customstep3un.svg",
			};
		},
		props:['step_name'],
		created() { 
			// 此处注意！！！建议在组件中建立一个值来间接使用父组件中的值，最好不要直接在子组件中修改父组件传入的值
			this.step = this.step_name
		},
		methods:{
			click_step(e){
				console.log(e.currentTarget.id)
				if (e.currentTarget.id == 'select_good'){
					this.step = e.currentTarget.id
					uni.redirectTo({
						url: "/pages/Custom_goods/Custom_goods"	
					})
				} else if (e.currentTarget.id == 'order_plan'){
					// 这里首先进行判断，如果购物车里没有商品的话就直接弹窗
					if (getApp().globalData.custom_cert.length==0){
						uni.showModal({
							showCancel: false,
							content: "请选择配送商品",
						})
					} else {
						// 如果购物车里有商品的话就通过遍历购物车里的商品判断是否存在该方案的商品
						for (let i=0; i<getApp().globalData.custom_cert.length; i++){
							var item = getApp().globalData.custom_cert[i]
							if (item.plan_name==getApp().globalData.select_plan){
								this.step = e.currentTarget.id
								uni.redirectTo({
									url: "/pages/order_plan/order_plan"
								})	
								break
							} 
							if (i==(getApp().globalData.custom_cert.length-1)){
								uni.showModal({
									showCancel: false,
									content: "请选择配送商品",
								})
							}
						}
					}
				} else {
					if (getApp().globalData.custom_cert.length==0){
						uni.showModal({
							showCancel: false,
							content: "请选择配送商品",
						})
					} else {
						this.step = e.currentTarget.id
						// 调用支付接口
						// uni.requestPayment({
							
						// })
						// 支付成功则跳转订单界面
						uni.redirectTo({
							url: "/pages/pay_plan/pay_plan"	
						})
					}
				}
			}
		}
	}
</script>

<style>
.customstep_img1{
	width: 250rpx;
	height: 100rpx;
	z-index: 3;
	position: relative;
	left: 45rpx;
	border-radius: 80rpx 0 0 80rpx;
}
.customstep_img2{
	z-index: 2;
	width: 250rpx;
	height: 100rpx;
}
.customstep_img3{
	width: 250rpx;
	height: 100rpx;
	z-index: 1;
	position: relative;
	right: 45rpx;
	border-radius: 0 80rpx 80rpx 0;
}
</style>

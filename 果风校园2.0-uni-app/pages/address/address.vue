<template>
	<view>
		<view class="background">
			<image class="address_img" src="/static/img/address_img.png"></image>
			<view class="phone">
				<input :value="phone" type="number" @input="input_phone" v-if="phone"/>
				<input placeholder="填入您的电话号码,以便我们确认您的身份" type="number" @input="input_phone" v-if="!phone"/>
				<image src="/static/img/phone.svg"></image>
			</view>
			<new_input type="text" item_name="学校名" item_id="school" item_image="/static/img/school.svg" :value="school"></new_input>
			<new_input type="text" item_name="公寓名" item_id="apartment" item_image="/static/img/school_bus.svg" :value="apartment"></new_input>
			<new_input type="text" item_name="寝室号" item_id="dormitory" item_image="/static/img/dormitory.svg" :value="dormitory"></new_input>
			<view style="height: 170rpx;"></view>
			<view class="save" @click="save_position">
				<image src="/static/img/save.svg"></image>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return { 
				"school" : getApp().globalData.position['school'],
				"apartment": getApp().globalData.position['apartment'],
				"dormitory": getApp().globalData.position['dormitory'],
				"phone":  getApp().globalData.position['phone']
			}
		},
		methods: {
			input_phone(e){
				getApp().globalData.position['phone'] = e.detail.value
			},
			save_position(e){
				console.log(getApp().globalData.position)
				uni.request({
					url: getApp().globalData.server + '/index.php/Home/GuoFeng/subAddress',
					data:{
						'user_id': getApp().globalData.openid,
						"school" : getApp().globalData.position['school'],
						"apartment": getApp().globalData.position['apartment'],
						"dormitory": getApp().globalData.position['dormitory'],
						"phone":  getApp().globalData.position['phone']
					},
					method:"POST",
					header: {
						'content-type': "application/x-www-form-urlencoded"
					},
					dataType: 'json',
					success:function(res){
						if (res.data.error_code == 0){
							console.log("成功修改地址") 
						}
					},
					complete:function(res){
						uni.navigateBack({
							delta:1
						})
					}
				})
			}
		}
	}
</script>

<style>
	page{
		background-color: #f6f9fc;
	}

	.save{
		background-color: white;
		width: 100%;
		height: 150rpx;
		position: fixed;
		bottom: 0;
		display: flex;
		justify-content: center;
		align-items: center;
		border-radius: 25rpx 25rpx 0 0;
	}
	.save image{
		width: 700rpx;
		height: 100rpx;
	}

.phone image {
	width: 36rpx;
	height: 42rpx;
	margin-right: 20rpx;
}
.phone input{
	font-style: normal;
	font-weight: bold;
	font-size: 30rpx;
	line-height: 38rpx;
	/* identical to box height */
	
	letter-spacing: -0.3px;
	width: 100%;
	color: #979797;
	
	margin-left: 20rpx;

}
.background{
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-left: 5%;
	margin-right: 5%;
}
.address_img{
	border-radius: 20rpx;
}
.phone{
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding-left: 20rpx;
	padding-right: 20rpx;
	background-color: white;
	height: 90rpx;
	width: 680rpx;
	margin-top: 20rpx;
	border-radius: 20rpx;
}
</style>

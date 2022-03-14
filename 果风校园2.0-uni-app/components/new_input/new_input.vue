<template>
	<view>
		<view class="input_temp">
			<input :id="item_id" :type="type" @input="input" :value="value"/>
			<view class="divider1"></view>
			<view class="item">
				<view class="item_name">
					<text>{{item_name}}</text>
					<view class="divider2"></view>
				</view>
				<image :src="item_image"></image>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		name:"new_input",
		data() {
			return {

			};
		},
		props:['item_name','item_id',"item_image","type","value"],	//接受父组件传递过来的商品信息
		methods: {
			input(e){
				// console.log(e)
				// console.log(e.detail.value)
				// console.log(e.target.id)
				// 将全局中的地址修改
				if (e.target.id == "school"){
					getApp().globalData.position["school"] = e.detail.value
				}
				if (e.target.id == "apartment"){
					getApp().globalData.position["apartment"] = e.detail.value
				}
				if (e.target.id == "dormitory"){
					getApp().globalData.position["dormitory"] = e.detail.value
				}
			}
		}
	}
</script>

<style>
.item{
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-left: 40rpx;
	margin-right: 40rpx;
	height: 45%;
}
.item image{
	width: 40rpx;
	height: 40rpx;
}

.input_temp{
	background-color: white;
	height: 130rpx;
	width: 720rpx;
	margin-top: 20rpx;
	border-radius: 20rpx;
	 border: 2px solid #707070;
}

.input_temp input{
	margin-left: 40rpx;
	height: 55%;
	
	font-style: normal;
	font-weight: bold;
	font-size: 30rpx;
	line-height: 38rpx;
	/* identical to box height */
	letter-spacing: -0.3px;
	color: #000000;
}

.item_name{
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.item_name text{
	font-style: normal;
	font-weight: bold;
	font-size: 24rpx;
	line-height: 30rpx;
	text-align: center;
	letter-spacing: -0.6rpx;
	color: #707070;
}

.divider1{
	border: 1rpx solid #303030;
}

/* .divider2{
	border: 1rpx solid #303030;
	width: 70rpx;
} */
</style>

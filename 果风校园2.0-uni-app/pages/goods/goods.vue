<template>
	<view>
		<!-- 商品选择栏 -->
		<Goods_bar></Goods_bar>
		<!-- 步骤栏 -->
		<step_bar :step="step"></step_bar> 
		<view style="display: flex; justify-content: center; margin-top: 36rpx;">
			<view style="display: flex; justify-content: space-between; width: 680rpx;">
				<text class="text_item">商品列表</text>
				<view style="display: flex; align-items: center;">
					<text class="text_item">销售热度</text>
					<image src="/static/img/arrow.svg" class="arrow2"></image>
				</view>		
			</view>
		</view>
		<goods_item :goods="goods" @send_msg="get_msg"></goods_item>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				goods:[],
				step: 1
			}
		},
		onLoad(custom_type) {
			var that = this
			console.log("商品界面onLoad中......")
			// console.log(custom_type)
			uni.request({
				url: getApp().globalData.server + '/index.php/Home/GuoFeng/Find_goods',
				data:{
					
				},
				method:"POST",
				header: {
					'content-type': "application/x-www-form-urlencoded"
				},
				dataType: 'json',
				success:function(res){
					console.log("成功获取到商品信息") 
					console.log(res.data)
					that.goods = res.data
				}
			})
			if (custom_type) {
				// 发送信息的页面
				// $emit(eventName, data)  
				console.log("发送定制服务信息")
				uni.$emit('send_type',custom_type.custom_type)
			}
		},
		methods: {
			// 通过子组件传来的商品选购数量更新父组件中的商品选购数量
			get_msg(num,index){
				console.log("子给父传值")
				this.goods[index].goods_cert = num
			},
		}
	}
</script>

<style>
page{
	background-color: #f6f9fc;
}
.arrow2{
	width: 30rpx;
	height: 30rpx;
	transform:rotate(90deg);
	margin-left: 10rpx;
}
.text_item{
	font-style: normal;
	font-weight: 800;
	font-size: 11.8277px;
	line-height: 16px;
}
</style>

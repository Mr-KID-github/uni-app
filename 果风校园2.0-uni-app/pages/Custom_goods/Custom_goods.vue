<template>
	<view>
		<!-- 商品选择栏 -->
		<Goods_bar></Goods_bar>
		<view style="display: flex; justify-content: center; margin-top: 36rpx;">
			<view style="display: flex; justify-content: space-between; width: 680rpx; align-items: center;">
				<text class="text_item">商品列表</text>
				<text class="plan_goods_text">方案一可选 {{1}}/{{2}} 果茶 {{1}}/{{1}} 果捞 {{1}}/{{3}} 果盘</text>
				<view style="display: flex; align-items: center;">
					<text class="text_item">销售热度</text>
					<image src="/static/img/arrow.svg" class="arrow2"></image>
				</view>		
			</view>
		</view>
		<goods_item :goods="goods" @send_msg="get_msg" custom=true :plan="plan"></goods_item>
		<view style="height: 180rpx;"></view>
		<custom_bar step_name="select_good"></custom_bar>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				goods:[],
				plan: '',
			}
		},
		onLoad() {
			this.plan = getApp().globalData.select_plan
			// console.log(this.plan)
			console.log("商品界面onLoad中......")
			var that = this
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
					
					// 通过对比购物车里的商品和调用接口的商品更新商品状态（是否在购物车中）
					for (let i=0; i<getApp().globalData.custom_cert.length; i++){
						var cert_item = getApp().globalData.custom_cert[i]
						for (let j=0; j<that.goods.length; j++){
							
							var goods_item = that.goods[j]
							if (cert_item.goods_name == goods_item.goods_name && cert_item.plan_name==getApp().globalData.select_plan){
								goods_item.goods_cert = cert_item.goods_num
								console.log("发现购物车中有此商品，更新商品的状态！！！")
								break
							}
						}
					}
				}
			})
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
.remind{
	position: fixed;
	bottom: 120rpx;
	font-style: normal;
	font-weight: 800;
	font-size: 28rpx;
	line-height: 40rpx;
	color: #000000;
}
.grad{
	position: fixed;
	bottom: 95rpx;
	height: 80rpx;
	width: 100%;
}
.plan_goods_text{
	font-style: normal;
	font-weight: bold;
	font-size: 21rpx;
	line-height: 24rpx;
	
	color: #000000;
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

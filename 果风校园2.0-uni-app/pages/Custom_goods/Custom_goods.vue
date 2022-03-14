<template>
	<view>
		<!-- 商品选择栏 -->
		<Goods_bar></Goods_bar>
		<view style="display: flex; justify-content: center; margin-top: 36rpx;">
			<view style="display: flex; justify-content: space-between; width: 680rpx; align-items: center;">
				<text class="text_item">商品列表</text>
				<text class="plan_goods_text">{{plan}}可选 {{num.guocha}}/{{num.totalguocha}} 果茶 {{num.guolao}}/{{num.totalguolao}} 果捞 {{num.guopan}}/{{num.totalguopan}} 果盘</text>
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
			if (getApp().globalData.select_plan == "方案一") {
				var num = getApp().globalData.plan1_num
			} 
			else if (getApp().globalData.select_plan == "方案二"){
				var num = getApp().globalData.plan2_num
			}
			else{
				var num = getApp().globalData.plan3_num
			}
			return {
				goods:[],
				plan: '',
				num,
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
					
					// 加载时，如果是从定制商品界面加入时，先从全局中获取到该用户是否有方案信息，如果有则加入购物车中
					if (getApp().globalData.plan.length != 0){
						for (let i=0; i<getApp().globalData.plan.length; i++){
							var item = getApp().globalData.plan[i]
							// 提取出商品
							console.log("开始提取"+item.plan_name+"商品")
							var re = item.plan_goods.split(' ')
							if (item.plan_name == getApp().globalData.select_plan){
								for (let i=0; i<re.length; i++){
									// 依据提取出的商品从数据库商品中获取商品信息并将其添加至定制购物车中
									for (let j=0; j<that.goods.length; j++){
										var good = that.goods[j]
										if (re[i] == good.goods_name){
											// console.log("找到其信息")
											// 将其添加至定制购物车
											var cert = getApp().globalData.custom_cert
											// 组件传值通过下列方式获得
											// console.log(JSON.parse(JSON.stringify(this.plan)))
											var cert_good = {
												"plan_name": that.plan,
												"goods_name": good.goods_name,
												"goods_num": 1,
												"goods_introduct": good.details,
												"goods_img": good.goods_picture1,
												"goods_id":good.goods_id,
												"goods_type": good.goods_type,
												"goods_water":good.water,
												"goods_energy":good.energy,
												"goods_sugar":good.sugar,
												"goods_price":good.goods_price,
											}
											let length = cert.length
											/*/
												如果购物车中没有商品，则不会执行下面循环，直接执行if (cert.length == 0) cert.push(cert_good)
												如果购物车中有商品，则执行循环
											/*/
											if (length == 0){
												console.log("购物车没有任何商品")
												cert.push(cert_good)
											} else {
												for (let k = 0; k < length; k++) {
													var item = cert[k] // item是指购物车中的商品
													// console.log(item.goods_name)
													/*/
														如果购物车中存在这个商品，则更新它的数量
													/*/
													if (item.goods_name == cert_good.goods_name && item.plan_name == getApp().globalData.select_plan) {
														console.log("购物车中存在这个商品")
														break
													}
													if(k == cert.length - 1){
														console.log("购物车中没有这个商品")
														cert.push(cert_good)
														break
													}
												}
											}
											// console.log(cert)
											break
										}
									}
								}
								console.log(getApp().globalData.custom_cert)
														
							}
							
						}
					}
					// 通过对比购物车里的商品和调用接口的商品更新商品状态（是否在购物车中）
					for (let i=0; i<getApp().globalData.custom_cert.length; i++){
						var cert_item = getApp().globalData.custom_cert[i]
						for (let j=0; j<that.goods.length; j++){
							var goods_item = that.goods[j]
							if (cert_item.goods_name == goods_item.goods_name&&getApp().globalData.select_plan==cert_item.plan_name){
								goods_item.goods_cert = cert_item.goods_num
								console.log("发现购物车中有此商品，更新商品的数据！！！")
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

<template>
	<view>
		<view class="background">
			<!-- 普通调用 -->
			<view v-for="item in goods" v-if="!custom">
				<view class="good" v-if="item.goods_type==type">
					<view class="img_bcg">
						<image class="good_img" :src="item.goods_picture1"></image>
						<image class="no_sides" src="/static/img/no_sides.svg" v-if="item.goods_number==0"></image>
					</view>
					<view class="good_text">
						<text class="good_name">{{item.goods_name}}</text>
						<text class="good_price">¥{{item.goods_price}}</text>
					</view>
					<image class="good_add" src="/static/img/Add.svg" v-if="item.goods_number!=0 && item.goods_cert==0"
						:id="item.goods_name" @click="add_num"></image>
					<image class="good_add" src="/static/img/No.svg" v-if="item.goods_number==0"></image>
					<view class="good_num" v-if="item.goods_cert != 0">
						<image src="/static/img/del.svg" class="num_img" @click="del_num" :id="item.goods_name"></image>
						<text class="num_text">{{ item.goods_cert }}</text>
						<image src="/static/img/add_num.svg" class="num_img" @click="add_num" :id="item.goods_name">
						</image>
					</view>
				</view>
			</view>
			<!-- 定制调用 -->
			<view v-for="item in goods" v-if="custom">
				<view class="good" v-if="item.goods_type==type">
					<view class="img_bcg">
						<image class="good_img" :src="item.goods_picture1"></image>
						<image class="no_sides" src="/static/img/no_sides.svg" v-if="item.goods_number==0"></image>
					</view>
					<view class="good_text">
						<text class="good_name">{{item.goods_name}}</text>
						<text class="good_price">¥{{item.goods_price}}</text>
					</view>
					<image class="good_add" src="/static/img/Add.svg" v-if="item.goods_number!=0 && item.goods_cert==0"
						:id="item.goods_name" @click="add_num"></image>
					<image class="good_add" src="/static/img/No.svg" v-if="item.goods_number==0"></image>
					<image src="/static/img/added.svg" class="good_add" @click="del_num" :id="item.goods_name"
						v-if="item.goods_cert != 0"></image>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		name: "goods_item",
		data() {
			return {
				type: 'tea', //展示的商品类型
				custom_cert: [] //定制购物车
			};
		},
		created() {
			console.log("Created执行了")
			// 接收兄弟组件Goods_bar传来的参数商品类型,进行商品类型的筛选展示
			uni.$on('select_bar', (select) => {
				console.log('接受到' + select)
				this.type = select
			})
		},
		props: ['goods', 'custom', 'plan'], //接受父组件传递过来的商品信息
		methods: {
			// 添加商品到购物车
			to_cert(good, method) {
				console.log("调用购物车方法")
				// console.log(good)
				// console.log(this.plan)
				if (this.custom) {
					var cert = getApp().globalData.custom_cert
					if (getApp().globalData.select_plan == "方案一") {
						var num = getApp().globalData.plan1_num
					} 
					else if (getApp().globalData.select_plan == "方案二"){
						var num = getApp().globalData.plan2_num
					}
					else{
						var num = getApp().globalData.plan3_num
					}
					// 组件传值通过下列方式获得
					// console.log(JSON.parse(JSON.stringify(this.plan)))
					var cert_good = {
						"plan_name": this.plan,
						"goods_name": good.goods_name,
						"goods_num": good.goods_cert,
						"goods_introduct": good.details,
						"goods_img": good.goods_picture1,
						"goods_id":good.goods_id,
						"goods_type": good.goods_type,
						"goods_water":good.water,
						"goods_energy":good.energy,
						"goods_sugar":good.sugar,
						"goods_price":good.goods_price,
					}
				} else {
					var cert = getApp().globalData.cert
					var cert_good = {
						"goods_id":good.goods_id,
						"goods_name": good.goods_name,
						"goods_num": good.goods_cert,
						"goods_price": good.goods_price,
					}
				}
				let length = cert.length
				/*/
					如果购物车中没有商品，则不会执行下面循环，直接执行if (cert.length == 0) cert.push(cert_good)
					如果购物车中有商品，则执行循环
				/*/
				for (let i = 0; i < length; i++) {
				
					var item = cert[i] // item是指购物车中的商品
					// console.log(item.goods_name)
					/*/
						如果购物车中存在这个商品，则更新它的数量
					/*/
					if (item.goods_name == cert_good.goods_name) {
						console.log("购物车中存在这个商品,更新它的数量")
						/*/
							如果购物车中这个商品的数量为0，则从购物车中移除
						/*/
						// 如果是定制服务的话发现购物车中有此商品的话直接退出或者移除退出,item.plan_name != getApp().globalData.select_plan
						if (this.custom) {
							if (getApp().globalData.select_plan==item.plan_name){
								console.log("购物车中存在这个方案的商品，更新它的数量")
								if (cert_good.goods_num == 0) {
									cert.splice(i, 1);
									if (cert_good.goods_type == "tea") {
										num.guocha -= 1
									}
									if (cert_good.goods_type == "fishing") {
										num.guolao -= 1
									}
									if (cert_good.goods_type == "fruit" ) {
										num.guopan -= 1
									}
									console.log("移除之后的购物车：" + cert)
									break
								}	
							}
						} else {
							// 如果是普通自选就要判断是否是0，如果是0就移除后退出，如果不是0就更新数量后退出
							if (cert_good.goods_num == 0) {
								cert.splice(i, 1);
								console.log("移除之后的购物车：" + cert)
								break
							}
							item.goods_num = cert_good.goods_num
							break
						}
					}
					/*/
						如果购物车一直到购物车底都没有找到这个商品，则将其添加至购物车
					/*/
					if (i == cert.length - 1) {
						// 如果是定制服务的话还需要判断是否超过最大数量
						if (this.custom){
							if (cert_good.goods_type == "tea") {
								if (num.guocha >= num.totalguocha) {
									uni.showModal({
										showCancel: false,
										content: "对不起您选择的果茶数量已经超过限制",
									})
									good.goods_cert = 0
								} else {
									console.log("购物车中没有这个商品,将其添加进购物车,且没超过最大数量")
									num.guocha += 1
									cert.push(cert_good)
								}
							}
							if (cert_good.goods_type == "fishing") {
								if (num.guolao >= num.totalguolao) {
									uni.showModal({
										showCancel: false,
										content: "对不起您选择的果捞数量已经超过限制",
									})
									good.goods_cert = 0
								} else {
									num.guolao += 1
									cert.push(cert_good)
								}
							}
							if (cert_good.goods_type == "fruit") {
								if (num.guopan >= num.totalguopan) {
									uni.showModal({
										showCancel: false,
										content: "对不起您选择的果盘数量已经超过限制",
									})
									good.goods_cert = 0
								} else {
									num.guopan += 1
									cert.push(cert_good)
								}
							}
						} else {
							// 如果不是定制服务的话就直接添加进购物车
							console.log("购物车中没有这个商品,将其添加进购物车")
							cert.push(cert_good)
						}
					}
				}
				if (cert.length == 0 && method == "add") {
					if (cert_good.goods_type == "tea") {
						num.guocha += 1
					}
					if (cert_good.goods_type == "fishing") {
						num.guolao += 1
					}
					if (cert_good.goods_type == "fruit") {
						num.guopan += 1
					}
					cert.push(cert_good)
				}
				console.log("购物车内有：")
				console.log(cert)
				return good.goods_cert
			},
			// 添加商品数量，原理同减少商品数量方法一样
			add_num: function(e) {
				// console.log(e.target.id)
				for (let index = 0; index < this.goods.length; index++) {
					const element = this.goods[index];
					if (element.goods_name == e.target.id) {
						//索引是动态的 则使用下方方式
						this.goods[index].goods_cert = this.goods[index].goods_cert + 1
						console.log(this.goods[index])
						// 调用购物车接口，将商品选购信息添加到购物车中
						this.goods[index].goods_cert = this.to_cert(this.goods[index], "add")
						// this.get_tatol_price()
						// console.log(this.goods[index])
						// 子组件向父组件传值
						this.$emit("send_msg", this.goods[index].goods_cert, index)
						break
					}
				}
			},

			// 减少商品数量
			del_num: function(e) {
				console.log(e.target.id)
				// 遍历商品表通过传入的商品名查找要操作的商品
				for (let index = 0; index < this.goods.length; index++) {
					const element = this.goods[index];
					if (element.goods_name == e.target.id) {
						//索引是动态的 则使用下方方式
						var real_num = this.goods[index].goods_cert - 1
						//       // 当商品num为0时即移除购物车内该商品
						//       if (real_num == 0) {
						//         var that = this
						//         // 移除商品时弹框询问用户是否确认移除
						//         uni.showModal({
						//           title:'移除商品',
						//           content:'确认移除商品？',
						//           showCancel:true,
						//           // 用户点击确定就更新购物车内商品表
						//           success(res){
						// 		console.log(res)
						// 		if (res.cancel) {
						// 			that.goods[index].goods_cert = 1
						// 		}
						// 		if (res.confirm) {
						// 			that.goods[index].goods_cert = 0
						// 		}
						//             }
						//         })
						//       }
						// if (real_num){
						// 	this.goods[index].goods_cert = real_num
						// }
						this.goods[index].goods_cert = real_num
						// 调用购物车接口，将商品选购信息添加到购物车中
						this.to_cert(this.goods[index], "del")
						// 子组件向父组件传值
						this.$emit("send_msg", this.goods[index].goods_cert, index)
						break
					}
				}
			},
		}
	}
</script>

<style>
	.background {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin-top: 10rpx;
	}

	.good_num {
		display: flex;
		height: 80rpx;
		width: 155rpx;
		position: absolute;
		right: 50rpx;
		justify-content: space-between;
		align-items: center;
	}

	.num_img {
		width: 60rpx;
		height: 60rpx;
	}

	.num_text {
		font-style: normal;
		font-weight: 800;
		font-size: 12px;
		line-height: 16px;
		text-align: center;
		letter-spacing: -0.393864px;

		color: #3C3C3C;
	}

	.good {
		width: 680rpx;
		height: 170rpx;
		margin-bottom: 30rpx;
		background-color: white;
		border-radius: 20rpx;
		display: flex;
		align-items: center;
	}

	.good_add {
		height: 80rpx;
		width: 155rpx;
		position: absolute;
		right: 50rpx;
	}

	.good_text {
		display: flex;
		flex-direction: column;
		justify-content: space-around;
		position: relative;
		right: 60rpx;
		margin-left: 120rpx;
		font-style: normal;
		font-weight: 800;
		font-size: 13.799px;
		line-height: 19px;
		letter-spacing: 0.197129px;
		color: #3C3C3C;
	}

	.good_name {}

	.good_price {}

	.img_bcg {
		position: relative;
		left: 25rpx;
		display: flex;
		justify-content: center;
		align-items: center;
		background-color: #7cc7d0;
		width: 110rpx;
		height: 110rpx;
		border-radius: 30rpx;
	}

	.good_img {
		width: 95rpx;
		height: 95rpx;
		border-radius: 50rpx;
		background-color: #007AFF;
	}

	.no_sides {
		width: 120rpx;
		height: 40rpx;
		position: absolute;
		top: 85rpx;
	}
</style>

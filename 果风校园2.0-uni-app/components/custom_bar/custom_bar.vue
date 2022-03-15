<template>
	<view>
		<view style="display: flex; justify-content:center; position:fixed; bottom: 0;">
			<image class="customstep_img1" id="select_good" @click="click_step" mode="aspectFit"
				:src="step=='select_good'?step1:unstep1"></image>
			<image class="customstep_img2" id="order_plan" @click="click_step" mode="aspectFit"
				:src="step=='order_plan'?step2:unstep2"></image>
			<image class="customstep_img3" id="pay_plan" @click="click_step" mode=""
				:src="step=='pay_plan'?step3:unstep3"></image>
		</view>
	</view>
</template>

<script>
	export default {
		name: "custom_bar",
		data() {
			return {
				step: '',
				step1: "/static/img/customstep1.svg",
				unstep1: "/static/img/customstep1un.svg",
				step2: "/static/img/customstep2.svg",
				unstep2: "/static/img/customstep2un.svg",
				step3: "/static/img/customstep3.svg",
				unstep3: "/static/img/customstep3un.svg",
				
				plan: '',
				order: {
					user_id:'',
					goods: '', //商品信息
					phone: "", //电话
					address: "", //地址
					price: 0, //总价格
					// time: '',//订单时间
					Notification_Check: '',//订单提醒
					order_status: '未支付',
				},
				goods: '',
			};
		},
		props: ['step_name'],
		created() {
			// 此处注意！！！建议在组件中建立一个值来间接使用父组件中的值，最好不要直接在子组件中修改父组件传入的值
			this.step = this.step_name
		},
		onLoad() {
			
		},
		methods: {
			//获取时间函数
			getTime: function() {
				var date = new Date(),
					year = date.getFullYear(),
					month = date.getMonth() + 1,
					day = date.getDate(),
					hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours(),
					minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes(),
					second = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
				month >= 1 && month <= 9 ? (month = "0" + month) : "";
				day >= 0 && day <= 9 ? (day = "0" + day) : "";
				var timer = year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
				return timer;
			},
			// 支付订单方法
			pay_bill:function(plan){
				 console.log(plan)
				 var that = this
				//与服务器交互---支付接口
				uni.request({
				  url: getApp().globalData.server + '/index.php/Home/Pay/make_order',	// 微信小程序支付
				  method: "POST",
				  data: {
					openid: getApp().globalData.openid,
					data_total: plan.plan_price,
					crsNo: plan.plan_id,
				  },
				  header: {
					'content-type': 'application/x-www-form-urlencoded' // 默认值
				  },
				  success: function (res) {  //后端返回的数据
					var there = that
					var data = res.data;
					console.log(data);
					console.log(data["timeStamp"]);
					wx.requestPayment({
					  timeStamp: data['timeStamp'],
					  nonceStr: data['nonceStr'],
					  package: data['package'],
					  signType: data['signType'],
					  paySign: data['paySign'],
					  success: function (res) {
						//支付成功后调用修改订单支付状态接口
						wx.request({
						  url: getApp().globalData.server + '/index.php/Home/GuoFeng/modifyplan',
						  data:{
							plan_id: plan.plan_id
						  },
						  header: {
							'content-type': "application/x-www-form-urlencoded"
						  },
						  method: 'POST',
						  dataType: 'json',
						  success:function(res){
							console.log(res)
							if(res.data.error_code != 0){
							  wx.showModal({
								title:'哎呀~',
								content:'出错了呢！' + res.data.msg,
								showCancel: false,
							  })
							}else if(res.data.error_code == 0){
							  // console.log(res.data.data)
							  console.log("方案支付成功！")
							}
						  },
						  fail:function(res){
							wx.showModal({
							  title:'哎呀~~',
							  content:'网络不在状态呢！'
							})
						  },
						  complete:function(res){
							wx.hideLoading({
							  success: (res) => {},
							})
						  }
						})
						var here = there
						wx.showModal({
						  title: '支付成功',
						  content: '',
						  showCancel: false,
						  success (res) {
							if (res.confirm) {
							  console.log('用户点击确定')
							  // console.log(here.order)
							  getApp().globalData.plan = plan
							  console.log(plan)
							  // 支付成功则跳转订单界面
							  here.step = "pay_plan"
							  uni.redirectTo({
							  	url: "/pages/pay_plan/pay_plan" 
							  })
							}
						  }
						})
					  },
					  fail: function (res) {
						console.log("小程序这边调起支付失败啦")
						console.log(res);
					  }
					})
				   }
				 });
			},
			push_order:function() {
				this.order.user_id=getApp().globalData.openid
				this.goods = getApp().globalData.custom_cert
				this.plan = getApp().globalData.select_plan
				// //获取时间函数---
				// this.order.time = this.getTime()
				//获取地址和电话
				this.order.phone = getApp().globalData.position.phone
				this.order.address = getApp().globalData.position.school + getApp().globalData.position.apartment +
					getApp().globalData.position.dormitory
				//获取定制提醒信息
				if (this.plan == '方案一') {
						
					this.order.Notification_Check = getApp().globalData.Notification_Check.N1
						
				} else if (this.plan == '方案二') {
					this.order.Notification_Check = getApp().globalData.Notification_Check.N2
						
				} else {
					this.order.Notification_Check = getApp().globalData.Notification_Check.N3
						
				}
				//获取当前方案的商品，放在订单数组中
				var that = this
				for (let i = 0; i < this.goods.length; i++) {
					var item = this.goods[i]
					if (item.plan_name == that.plan) {
						that.order.goods += item.goods_name + " "
						that.order.price += Number(item.goods_price)
						console.log(that.order.goods)
					}
				}
				console.log(this.order)
				console.log(this.plan)
				
				var that = this
				uni.request({
					url: getApp().globalData.server + '/index.php/Home/GuoFeng/createplan',//确认订单，发送订单信息
					data: {
						plan_name: that.plan,
						user_id: that.order.user_id,
						plan_goods: that.order.goods,
						plan_price: that.order.price,
						plan_time: that.getTime(),
						plan_position: that.order.address,
						plan_phone: that.order.phone,
						plan_Notification: that.order.Notification_Check,
						plan_status: '未支付'		// 生成未支付订单
					},
					method: "POST",
					header: {
						'content-type': "application/x-www-form-urlencoded"
					},
					dataType: 'json',
					success: function(res) {
						console.log(res.data)
						// 调用支付接口
						that.pay_bill(res.data.data)
					},
					fail(res) {
						console.log(res)
					}
				})
			},
			
			change_plan(plan){
				console.log("已存在方案，开始修改方案")
				console.log(plan)
				var that = this
				uni.request({
					url: getApp().globalData.server + '/index.php/Home/GuoFeng/changeplan',//确认订单，发送订单信息
					data: {
						plan_id: plan.plan_id,
						plan_goods: plan.plan_goods,
						plan_notification: plan.plan_notification
					},
					method: "POST",
					header: {
						'content-type': "application/x-www-form-urlencoded"
					},
					dataType: 'json',
					success: function(res) {
						console.log(res)
						// 调用支付接口
						that.pay_bill(plan)
					},
					fail(res) {
						console.log(res)
					}
				})
				
			},
			
			click_step(e) {
				console.log(e.currentTarget.id)
				if (e.currentTarget.id == 'select_good' && this.step == 'order_plan') {
					this.step = e.currentTarget.id
					uni.redirectTo({
						url: "/pages/Custom_goods/Custom_goods"
					})
				} else if (e.currentTarget.id == 'order_plan' && (this.step != "order_plan")) {
					// 这里首先进行判断，如果购物车里没有商品的话直接弹窗
					if (getApp().globalData.custom_cert.length == 0) {
						uni.showModal({
							showCancel: false,
							content: "请选择配送商品",
						})
					} else {
						// 如果购物车里有商品的话就通过遍历购物车里的商品判断是否存在该方案的商品
						for (let i = 0; i < getApp().globalData.custom_cert.length; i++) {
							var item = getApp().globalData.custom_cert[i]
							if (item.plan_name == getApp().globalData.select_plan) {
								this.step = e.currentTarget.id
								uni.redirectTo({
									url: "/pages/order_plan/order_plan"
								})
								break
							}
							if (i == (getApp().globalData.custom_cert.length - 1)) {
								uni.showModal({
									showCancel: false,
									content: "请选择配送商品",
								})
							}
						}
					}
				} else if(e.currentTarget.id == 'pay_plan' && this.step == 'order_plan'){
					// 判断该用户是否已经生成该方案
					if (getApp().globalData.plan.length != 0){
						for (let i=0; i<getApp().globalData.plan.length; i++){
							var item = getApp().globalData.plan[i]
							console.log(item.plan_status)
							if (item.plan_name==getApp().globalData.select_plan){
								// 此处又分为两种情况，一是订单已支付，二是订单未支付（此处计划暂时只支持未支付方案的修改，已支付方案的修改涉及到后续的配送问题，比较麻烦）
								if(item.plan_status == "已支付"){
									this.step = e.currentTarget.id
									uni.redirectTo({
										url: "/pages/pay_plan/pay_plan"
									})
								} else {
									// 如果已有方案，则对现有方案进行修改：
									// 调用修改订单接口
									var data = {}
									for (let i=0; i<getApp().globalData.plan.length; i++){
										if (getApp().globalData.plan[i].plan_name == getApp().globalData.select_plan){
											data = getApp().globalData.plan[i]
											break
										}
									}
									this.change_plan(data)
								}
								break
							}
						}
					}else{
						// 调用支付接口
						this.push_order()
					}
				} else {
					uni.showModal({
						showCancel:false,
						content: "请先确认您的订单",
					})
				}
			}
		}
	}
</script>

<style>
	.customstep_img1 {
		width: 250rpx;
		height: 100rpx;
		z-index: 3;
		position: relative;
		left: 45rpx;
		border-radius: 80rpx 0 0 80rpx;
	}

	.customstep_img2 {
		z-index: 2;
		width: 250rpx;
		height: 100rpx;
	}

	.customstep_img3 {
		width: 250rpx;
		height: 100rpx;
		z-index: 1;
		position: relative;
		right: 45rpx;
		border-radius: 0 80rpx 80rpx 0;
	}
</style>

<template>
	<view>
		<!-- 步骤2 的导航栏 -->
		<step_bar :step="step"></step_bar>
		<!-- 订单内容 -->
		<view class="content_bck">
			<view class="content">
				<view class="content_item" v-for="item in cert">
					<view class="good_content">
						<text class="content_name">{{item.goods_name}}</text>
						<text class="content_num">{{item.goods_price}} 元 × {{item.goods_num}} 份</text>
					</view>
					<text class="content_price">￥{{item.goods_price * item.goods_num}}</text>
				</view>
				<view style="border: 2rpx solid #979797; width: 90%; margin-left: 5%; margin-right: 5%;"></view>
				<view class="tip">
					<text class="tip_text">服务费</text>
					<text>￥5</text>
				</view>
				<view style="border: 2rpx solid #979797; width: 90%; margin-left: 5%; margin-right: 5%;"></view>
				<view class="total_price">
					<view>Total:</view>
					<text>￥{{total_price + 5}}</text>
				</view>
			</view>
		</view>
		<!-- 地址 -->
		<view style="margin-bottom: 180rpx;">
			<position></position>
		</view>
		<view class="pay">
			<image src="/static/img/pay.svg" @click="pushOrder"></image>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				step: 2,
				cert: [

				], // 购物车
				total_price: 0,
			}
		},
		onLoad() {
			this.cert = getApp().globalData.cert
			this.total_price = getApp().globalData.total_price
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
			pay_bill:function(order){
				console.log(order)
				//与服务器交互---支付接口
				uni.request({
				  url: getApp().globalData.server + '/index.php/Home/Pay/make_order',	// 微信小程序支付
				  method: "POST",
				  data: {
					openid: getApp().globalData.openid,
					data_total: order.order_money,
					crsNo: order.order_id
				  },
				  header: {
					'content-type': 'application/x-www-form-urlencoded' // 默认值
				  },
				  success: function (res) {  //后端返回的数据
					var data = res.data;
					console.log(data);
					console.log(data["timeStamp"]);
					console.log(order)
					wx.requestPayment({
					  timeStamp: data['timeStamp'],
					  nonceStr: data['nonceStr'],
					  package: data['package'],
					  signType: data['signType'],
					  paySign: data['paySign'],
					  success: function (res) {
						//支付成功后调用修改订单支付状态接口
						wx.request({
						  url: getApp().globalData.server + '/index.php/Home/GuoFeng/modifyorder',
						  data:{
							order_id: order.order_id
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
							  console.log("订单支付成功！")
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
						wx.showModal({
						  title: '支付成功',
						  content: '',
						  showCancel: false,
						  success (res) {
							if (res.confirm) {
							  console.log('用户点击确定')
							  wx.reLaunch({
								url: '/pages/review_bill/review_bill',
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
			
			//构造订单函数
			pushOrder: function() {
				// 将全局的order地址给order
				var order = getApp().globalData.order
				console.log(order)
				// 对全局的订单数据进行赋值
				order.goods = getApp().globalData.cert//购物车内信息
				order.order_money = getApp().globalData.total_price + 5//总价格
				order.order_time = this.getTime()//获得当前时间
				order.order_phone = getApp().globalData.position.phone
				//拼接当前配送地址
				order.position = getApp().globalData.position.school+getApp().globalData.position.apartment+getApp().globalData.position.dormitory
				// 直接将信息存入数据库这种方法高效但是不可取，一来占用内存大，二来想要从数据库中提取这些信息的部分数据不便，因此这里仅做再次确认信息的展示
				var show_goods = ''	//展示出来的订单商品
				var goods_id = ''	//所有订单商品的id集合
				for (let i=0; i<order.goods.length; i++){
					var item = order.goods[i]
					show_goods = show_goods + "商品:"+ item.goods_name+" 数量:"+item.goods_num + " 单价:"+item.goods_price + " \r\n"
				}
				console.log(show_goods)
				var show_order =show_goods + "\r\n服务费：5(包括配送费和包装费)" + "\r\n总价："+order.order_money+"元  \r\n地址："+order.position + "\r\n联系电话："+order.order_phone
				console.log(show_order)
				// 确认订单，弹窗显示订单内容
				var that = this
				uni.showModal({
					title: '请再次确认订单',
					content: show_order,
					showCancel: false,
					cancelText: "取消", // 取消按钮的文字  
						confirmText: "确认", // 确认按钮的文字  
						showCancel: true, // 是否显示取消按钮，默认为 true
						confirmColor:'#39B54A' ,
						cancelColor: '#f55850',
						success: (res) => {
							if (res.confirm) {
								uni.request({
									url: getApp().globalData.server + '/index.php/Home/GuoFeng/createorder',//确认订单，发送订单信息
									data: {
										user_id: getApp().globalData.openid,
										order_goods: show_goods,
										order_money: order.order_money,
										order_time: order.order_time,
										order_position: order.position,
										order_phone: order.order_phone,
										order_status: '未支付'		// 生成未支付订单
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
									}
								})
							}
						}
				})
			}
		}
	}
</script>

<style>
	page {
		background-color: #f6f9fc;
	}
	uni-modal .uni-modal__bd{      
	    white-space: pre-wrap;      
	}
	.pay {
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

	.pay image {
		width: 700rpx;
		height: 100rpx;
	}

	.total_price {
		display: flex;
		position: relative;
		left: 65%;
		margin-bottom: 20rpx;
		margin-top: 20rpx;
	}

	.total_price view {
		font-style: normal;
		font-weight: normal;
		font-size: 18px;
		line-height: 23px;
		/* identical to box height */

		text-align: center;
		letter-spacing: -0.3px;

		color: #000000;
	}

	.total_price text {
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		line-height: 23px;
		/* identical to box height */

		text-align: center;
		letter-spacing: -0.3px;

		color: #000000;
	}

	.tip {
		display: flex;
		justify-content: space-between;
		margin: 5%;
	}

	.tip_text {
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		line-height: 23px;
		/* identical to box height */

		text-align: center;
		letter-spacing: -0.3px;

		color: #000000;
	}

	.content_bck {
		width: 100%;
		display: flex;
		justify-content: center;
	}

	.content {
		width: 680rpx;
		background-color: white;
		margin-top: 40rpx;
		border-radius: 25rpx;
	}

	.content_item {
		display: flex;
		justify-content: space-between;
		margin: 35rpx;
	}

	.good_content {
		display: flex;
		flex-direction: column;
	}

	.content_name {
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		line-height: 23px;
		/* identical to box height */

		letter-spacing: -0.3px;

		color: #000000;

	}

	.content_num {
		font-style: normal;
		font-weight: normal;
		font-size: 28rpx;
		line-height: 40rpx;
		/* identical to box height */

		letter-spacing: -0.3px;

		color: #979797;
	}

	.content_price {
		font-style: normal;
		font-weight: bold;
		font-size: 18px;
		line-height: 23px;
		/* identical to box height */

		text-align: center;
		letter-spacing: -0.3px;

		color: #000000;
	}
</style>
